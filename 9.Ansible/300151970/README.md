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

 ## Travail demandé
 
Créer la structure des fichiers

/300151970

├──files
    |
    ─ index.html
    
├── images

├── inventory.ini

├── playbook.yml

└── files/index.html


le package ansible n’existe pas (ou plus) directement sur Chocolatey. Et même quand il existait, Ansible n’est pas conçu pour tourner nativement sur Windows.

🔹Solution utilisé — WSL

WSL(Windows Subsystem for Linux) est une fonctionnalité de Windows qui te permet de faire tourner une distribution Linux directement sur Windows, sans machine virtuelle complète.

Installe WSL :

wsl --install
Redémarre ton PC

```bash
wsl
```

