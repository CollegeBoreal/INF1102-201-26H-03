# ❔ Comment choisir le bon outil de scripting pour le bon besoin ?

*(Bash, PowerShell, Python… et autres)*

Choisir le **bon outil de scripting** ne revient pas à désigner “le meilleur langage” en général, mais à comprendre **le problème à résoudre, l’environnement d’exécution, et les personnes qui devront maintenir le script**.

Ce guide te propose une **méthode de décision pragmatique**, suivie d’une comparaison des outils les plus courants et d’exemples concrets.

***

## 1. Commencer par le besoin, pas par le langage

Pose‑toi d’abord ces questions :

### A. Où le script va‑t‑il s’exécuter ?

*   Linux / macOS
*   Windows
*   Multi‑plateforme
*   Cloud / conteneurs
*   Pipeline CI/CD

### B. Quel type de tâche ?

*   One‑liner ou automatisation rapide
*   Administration système
*   Manipulation de fichiers / texte
*   Appels d’API / orchestration
*   Logique complexe ou workflow long
*   Collage (“glue”) entre services

### C. Qui va le maintenir ?

*   Toi seul
*   Équipe DevOps
*   Administrateurs système
*   Développeurs
*   Équipe aux compétences mixtes

### D. Quelle est la durée de vie du script ?

*   Quelques minutes (ad‑hoc)
*   Quelques semaines (automatisation temporaire)
*   Plusieurs années (outil de production)

***

## 2. Bash (et autres shells POSIX)

### Idéal pour

✅ Automatisations rapides sur Linux/macOS  
✅ Opérations sur fichiers  
✅ Traitement de texte via pipes  
✅ Scripts CI sur runners Linux

### Points forts

*   Disponible partout sur Linux
*   Excellente composition avec les outils Unix (`grep`, `awk`, `sed`, `curl`)
*   Démarrage instantané
*   Parfait pour les pipelines simples

### Limites

*   Gestion des erreurs faible
*   Difficile à tester
*   Lisibilité médiocre à grande échelle
*   Débogage pénible
*   Problèmes de portabilité entre shells

### Quand choisir Bash

> « J’automatise des tâches système sur Linux/macOS et le script fait moins de \~200 lignes. »

```bash
grep "ERROR" *.log | awk '{print $1}' | sort | uniq -c
```

### Quand éviter Bash

*   Logique complexe
*   Scripts multi‑plateformes
*   Outils destinés à durer

***

## 3. PowerShell (Core / 7+)

### Idéal pour

✅ Administration Windows  
✅ Écosystème Microsoft (AD, Azure, M365)  
✅ Automatisation orientée objets  
✅ Scripts multi‑plateformes modernes

### Points forts

*   Pipeline basé sur des **objets**, pas du texte
*   Gestion des erreurs robuste
*   Excellente découvrabilité (`Get-Command`, `Get-Help`)
*   Modules très riches pour Windows et Azure
*   Disponible sur Linux/macOS (PowerShell 7+)

### Limites

*   Syntaxe verbeuse
*   Démarrage plus lent que Bash
*   Moins natif sur Linux serveur
*   Courbe d’apprentissage pour les non‑windowsiens

### Quand choisir PowerShell

> « Je gère Windows, Azure ou des services Microsoft, ou je veux une automatisation structurée. »

```powershell
Get-Service | Where-Object Status -eq "Stopped" | Stop-Service
```

### Quand éviter

*   Micro scripts ou one‑liners
*   Environnements ultra‑minimalistes

***

## 4. Python – le couteau suisse

### Idéal pour

✅ Automatisation complexe  
✅ Intégration d’API  
✅ Scripts multi‑plateformes  
✅ Outils maintenables dans le temps  
✅ Traitement de données

### Points forts

*   Syntaxe claire
*   Écosystème gigantesque
*   Tests faciles
*   Très lisible en équipe
*   Largement connu

### Limites

*   Nécessite un runtime
*   Démarrage plus lent qu’un shell
*   Gestion des dépendances
*   Surdimensionné pour les petits scripts

### Quand choisir Python

> « Ce script va évoluer, être partagé, ou interagir avec des APIs. »

```python
import requests

r = requests.get("https://api.example.com/status")
r.raise_for_status()
print(r.json())
```

### Quand éviter

*   Automatisations ultra‑simples
*   Commandes très courtes et fréquentes

***

## 5. Autres outils (dans leurs niches)

### Perl

✅ Anciens systèmes Unix  
✅ Traitement de texte très poussé  
❌ Lisibilité faible, communauté réduite

### Go

✅ Outils CLI robustes  
✅ Performance, binaire statique  
✅ Cloud‑native  
❌ Temps d’écriture plus long

### JavaScript / Node.js

✅ Outillage web  
✅ Automatisation événementielle  
✅ Multi‑plateforme  
❌ Dépendances envahissantes

### Ruby

✅ Scripts lisibles  
✅ Outils DevOps historiques (Chef)  
❌ Moins populaire aujourd’hui

***

## 6. Tableau de décision rapide

| Situation                    | Choix recommandé   |
| ---------------------------- | ------------------ |
| Admin Linux, script rapide   | Bash               |
| Admin Windows / Azure        | PowerShell         |
| Logique complexe, APIs       | Python             |
| CLI performante              | Go                 |
| Traitement de texte ponctuel | Bash / awk         |
| Orchestration cloud          | Python / Go        |
| Scripts CI/CD                | Bash ou PowerShell |

***

## 7. Règles pratiques

### ✅ Choisis **Bash** si :

*   Le script est court
*   Tu relies des commandes existantes
*   Tu es sur Unix
*   Le besoin est jetable

### ✅ Choisis **PowerShell** si :

*   Tu veux une structure claire
*   Les erreurs doivent être gérées proprement
*   Tu es dans l’écosystème Microsoft

### ✅ Choisis **Python** si :

*   Le script va grandir
*   Il sera maintenu par plusieurs personnes
*   Il traite des données ou parle à des APIs
*   Tu veux des tests et de la lisibilité

***

## 8. Le facteur souvent oublié : la maintenabilité

Pose‑toi franchement ces questions :

*   Quelqu’un d’autre peut‑il lire ce script dans 6 mois ?
*   Peut‑on le tester ?
*   Échoue‑t‑il de manière sûre ?
*   Peut‑on le déboguer à 2 h du matin ?

Souvent, **Python ou PowerShell gagnent non pas parce qu’ils sont plus rapides, mais parce qu’ils sont plus clairs**.

***

## 9. En résumé

> **Utilise les shells pour orchestrer, les langages de script pour la logique, et les langages compilés pour livrer des outils.**
