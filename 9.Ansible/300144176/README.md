awa
# 🧪 TP : Déploiement automatisé Nginx

## 🎯 Objectif
Ce TP a pour but de créer un système automatisé qui :

- Installe **Nginx** sur un serveur distant
- Déploie une **page web personnalisée**
- Active le **service Nginx**

L’objectif est de se familiariser avec **Ansible** et le concept d’**Infrastructure as Code (IaC)**.

---

## 📋 Travail demandé

### 1️⃣ Créer la structure des fichiers
```bash
/
├──files
    ├── index.html
├── images
├── inventory.ini
├── playbook.yml
└── files/index.html
```


<img width="1917" height="375" alt="image" src="https://github.com/user-attachments/assets/188502a6-754b-4895-98d7-29ec1bbe2ab8" />



<img width="1892" height="984" alt="image" src="https://github.com/user-attachments/assets/f7e61c72-2e58-418d-aa8d-67d6fbd34dbd" />





Idempotence signifie que tu peux exécuter la même tâche plusieurs fois sans changer le résultat si l’état désiré est déjà atteint.

present	Assure que la ressource existe (package installé, fichier présent). Ne démarre pas un service.
started	Pour un service, assure qu’il est en cours d’exécution. Ne l’installe pas si le package n’existe pas (mais souvent combiné avec enabled pour démarrage automatique).

become: yes permet d’exécuter la tâche avec les privilèges root (ou un autre utilisateur via become_user).


## ✅ Conclusion et apprentissages

### Conclusion
Le TP montre qu’**Ansible permet de déployer et configurer des services de manière automatisée et fiable**. Grâce à l’approche déclarative, l’état des serveurs peut être géré facilement, reproductible et sécurisé.

