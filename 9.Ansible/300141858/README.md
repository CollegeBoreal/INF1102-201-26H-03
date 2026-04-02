\# TP Ansible - Déploiement automatisé Nginx



\## Étudiant



\*\*Nom :\*\* Abdou Karim NIANG

\*\*Identifiant Boréal :\*\* 300141858



\---



\## Objectif



Ce TP consiste à utiliser \*\*Ansible\*\* pour automatiser la configuration d’un serveur web.



Le playbook permet de :



\* installer \*\*nginx\*\*

\* copier une page web HTML

\* démarrer et activer le service \*\*nginx\*\*



\---



\## Structure du projet



```bash

300141858/

├── README.md

├── inventory.ini

├── playbook.yml

└── files/

&#x20;   └── index.html

```



\---



\## Fichier inventory.ini



```ini

\[web]

localhost ansible\_connection=local

```



\---



\## Fichier playbook.yml



```yaml

\- name: Installer et configurer nginx

&#x20; hosts: web

&#x20; become: yes



&#x20; tasks:

&#x20;   - name: Installer nginx

&#x20;     apt:

&#x20;       name: nginx

&#x20;       state: present

&#x20;       update\_cache: yes



&#x20;   - name: Copier la page HTML

&#x20;     copy:

&#x20;       src: files/index.html

&#x20;       dest: /var/www/html/index.nginx-debian.html



&#x20;   - name: Demarrer nginx

&#x20;     service:

&#x20;       name: nginx

&#x20;       state: started

&#x20;       enabled: yes

```



\---



\## Fichier files/index.html



```html

<!DOCTYPE html>

<html>

<head>

&#x20;   <meta charset="UTF-8">

&#x20;   <title>TP Ansible - 300141858</title>

</head>

<body>

&#x20;   <h1>Déploiement réussi avec Ansible</h1>

</body>

</html>

```



\---



\## Commande d’exécution



```bash

ansible-playbook -i inventory.ini playbook.yml

```



\---



\## Résultat obtenu



Exécution réussie :



```bash

PLAY RECAP \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

localhost : ok=4 changed=1 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0

```



\---



\## Vérification



```bash

curl http://localhost

```



Résultat :



```html

<!DOCTYPE html>

<html>

<head>

&#x20;   <meta charset="UTF-8">

&#x20;   <title>TP Ansible - 300141858</title>

</head>

<body>

&#x20;   <h1>Déploiement réussi avec Ansible</h1>

</body>

</html>

```



\---



\## Conclusion



Ce TP démontre l’utilisation d’Ansible pour automatiser la configuration d’un serveur web de manière simple, rapide et reproductible.



