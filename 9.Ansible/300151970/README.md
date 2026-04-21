# TP09 : Leçon – Gestion de configuration avec Ansible (IaC)
---

## 👤 Étudiant

- **Nom et Prénoms :** Babatundé Adissa Fadolle Arouna  
- **Numéro étudiant :** 300151970  
- **Programme :** Techniques des systèmes informatiques  
- **Cours :** INF 1102-201 – Programmation de systèmes  
- **Session :** Hiver 2026  
- **Professeur :** Brice Robert  
- **Date de remise :** 12/04/2026  

---

## 🎯 Objectifs du TP

- Comprendre le concept de gestion de configuration  
- Expliquer le principe de *Infrastructure as Code (IaC)*  
- Différencier script impératif et approche déclarative  
- Écrire un playbook Ansible en YAML  
- Déployer automatiquement un serveur **Nginx** avec une page HTML  

---
Créer la structure des fichiers

```bash
/300151970
├──files
    ├── index.html
├── images
├── inventory.ini
├── playbook.yml
└── README.md
```


le package ansible n’existe pas (ou plus) directement sur Chocolatey. Et même quand il existait, Ansible n’est pas conçu pour tourner nativement sur Windows.

🔹Solution utilisé — WSL

WSL(Windows Subsystem for Linux) est une fonctionnalité de Windows qui te permet de faire tourner une distribution Linux directement sur Windows, sans machine virtuelle complète.

Installe WSL :

wsl --install
Redémarre ton PC

```bash
wsl
```

Installé Ansible :

```bash
sudo apt update
sudo apt install ansible-core -y
```

<img width="1465" height="715" alt="Ansible 13 docx" src="https://github.com/user-attachments/assets/707e00ec-89b0-403e-bd83-893e43160603" />


## Exécution du playbook

<img width="1462" height="487" alt="Ansible 11 docx" src="https://github.com/user-attachments/assets/6175ad12-dd2e-4437-9c6f-73a42fb1a5ce" />


## Resultat

<img width="1918" height="967" alt="Ansible 10 docx" src="https://github.com/user-attachments/assets/0c824af2-5471-483f-a955-a3bb1df7a6e7" />

## Commandes utile

``` bash
wsl -u root       # lancer WSL en mode root
wsl -l -v         # lister les distributions installées
```

Idempotence signifie que tu peux exécuter la même tâche plusieurs fois sans changer le résultat si l’état désiré est déjà atteint.

present Assure que la ressource existe (package installé, fichier présent). Ne démarre pas un service. started Pour un service, assure qu’il est en cours d’exécution. Ne l’installe pas si le package n’existe pas (mais souvent combiné avec enabled pour démarrage automatique).

become: yes permet d’exécuter la tâche avec les privilèges root (ou un autre utilisateur via become_user).

## Conclusion et apprentissages

## Conclusion

Le TP montre qu’Ansible permet de déployer et configurer des services de manière automatisée et fiable. Grâce à l’approche déclarative, l’état des serveurs peut être géré facilement, reproductible et sécurisé.

## Choses apprises

Comprendre le fonctionnement d’Ansible et son idempotence
Installer et utiliser Ansible sur WSL ou Linux
Créer un playbook pour installer Nginx, déployer une page web et gérer les services
Utiliser des handlers pour redémarrer automatiquement les services
Gérer la structure des fichiers et l’inventory
Notions importantes : become: yes, present, started, idempotence
