# Projet 1 - Suivi de meteo quotidienne

# INF 1102-201 | Programmation de systemes | Hiver 2026

`
  ## INFORMATIONS DE L ETUDIANT

  **Etudiant** : Babatunde Adissa Fadolle Arouna | 300151970
  
  **Hiver** : 2026
  
  **Programme**  : Techniques des systemes informatiques
  
  **Cours** : INF 1102-201 Programmation de systemes
  
  **Professeur** : Brice Robert
  

 ## 1. OBJECTIF DU PROJET

Ce projet recupere automatiquement les donnees meteo de trois
grandes villes canadiennes (Toronto, Montreal, Vancouver) via
l API publique OpenWeatherMap, puis genere :

  - Un rapport texte complet   (output/rapport.txt)
  - 4 graphiques automatiques  (output/*.png)
  - Un rapport Jupyter interactif (RAPPORT.ipynb)

Les technologies utilisees sont :
  - PowerShell Windows : appel de l API REST
  - Python 3 (VM Ubuntu) : analyse des donnees + graphiques
  - Bash (VM Ubuntu) : orchestration du pipeline
  - Jupyter Notebook : rapport interactif avec visualisations

    
    
  ## 2. STRUCTURE DU PROJET

```
/300151970/
|
|-- scripts/
|   |-- analyse.ps1       # PowerShell : appelle l API OpenWeatherMap
|   |-- analyse.sh        # Bash : orchestre et lance analyse.py
|   |-- analyse.py        # Python : analyse JSON + 4 graphiques
|   `-- requirements.txt  # Dependances Python requises
|
|-- data/
|   `-- meteo_raw.json    # Donnees JSON brutes de l API (3 villes)
|
|-- output/
|   |-- rapport.txt                    # Rapport texte genere automatiquement
|   |-- graph_barres_temperatures.png  # Diagramme en bandes : temperatures
|   |-- graph_barres_humidite_vent.png # Diagramme en bandes : humidite/vent
|   |-- graph_circulaire_humidite.png  # Diagramme circulaire : humidite
|   `-- graph_circulaire_nuages.png    # Diagramme circulaire : nuages
|
|-- images/
|   |-- capture_execution.png          # Capture du terminal apres execution
|   |-- capture_rapport.png            # Capture du rapport.txt
|   |-- capture_graphique_barres.png   # Capture des graphiques en bandes
|   `-- capture_graphique_circulaire.png # Capture des graphiques circulaires
|
|-- RAPPORT.ipynb    # Notebook Jupyter avec analyses et visualisations
`-- README.md        # Ce fichier - instructions completes
````


 ## 3. ENVIRONNEMENT D EXECUTION


  TERMINAL - PowerShell Windows
  --------------------------------
  
  Utilise pour :
    - Se connecter a la VM via SSH
    - Executer analyse.ps1 pour appeler l API OpenWeatherMap
    - Sauvegarder les donnees dans data/meteo_raw.json

  ## Connexion SSH :

  ````
  ssh -i $HOME\.ssh\ma_cle.pk `
-o StrictHostKeyChecking=no `
-o UserKnownHostsFile=NUL `
ubuntu@10.7.237.223
````

 ## 4. INSTALLATION DES DEPENDANCES

 ## Installer les dependances Python :
 
**Mise à jour et installation de python**

 ```bash
 sudo apt update
 sudo apt install python3 python3-pip -y
  ```
 <img width="1471" height="417" alt="Projet 1" src="https://github.com/user-attachments/assets/11a96f46-6068-473a-a9ff-70b2bdb77b8d" />

 <img width="1468" height="485" alt="Projet 2" src="https://github.com/user-attachments/assets/cf7c1ef9-75cf-4244-9e0a-8b549d925dd8" />

 

  ```bash
  pip3 install -r scripts/requirements.txt
  ```

<img width="1471" height="703" alt="Projet 4" src="https://github.com/user-attachments/assets/6c0ce294-c66e-48ca-b7d6-d8398d198a9b" />


<img width="1471" height="703" alt="Projet 4" src="https://github.com/user-attachments/assets/1e390cde-738b-4456-a830-edb83ded7143" />

<img width="1467" height="285" alt="Projet 4-1" src="https://github.com/user-attachments/assets/3d5ffec3-9d23-4167-9c01-da72f6b0264f" />




  ## Dependances installes :
  
  ```bash
    - matplotlib >= 3.5.0  : generation des graphiques
    - requests  >= 2.28.0  : appels HTTP (optionnel pour API)
    - numpy                 : calculs numeriques pour graphiques
    - python3               : interpretatation des scripts
```


  ## 5. EXECUTION DU PROJET

  **ETAPE 3** - Lancer le script Bash principal
  
   ```bash
    bash scripts/analyse.sh
  ```

    Ce script fait automatiquement :
      [1/4] Verifie que le fichier JSON existe
      [2/4] Cree le dossier output/ si absent
      [3/4] Installe les dependances Python
      [4/4] Lance analyse.py pour l analyse et les graphiques

  ETAPE 4 - Ou lancer Python directement
  ----------------------------------------
    python3 scripts/analyse.py data/meteo_raw.json output/rapport.txt

  ETAPE 5 - Verifier les fichiers generes
  ----------------------------------------
    ls output/
    cat output/rapport.txt

  ETAPE 6 - Ouvrir le Notebook Jupyter
  --------------------------------------
    jupyter notebook RAPPORT.ipynb

    NOTE : Si vous etes sur la VM sans interface graphique,
    utilisez l option --no-browser et copiez le lien affiche
    dans votre navigateur Windows.
    

  ETAPE 7 - Pousser sur Git

  ```
    git add .
    git commit -m "Projet 1 - Suivi meteo - Babatunde Adissa Fadolle Arouna 300151970"
    git push
```


  ## 6. CAPTURES D ECRAN ATTENDUES

  **Placez vos captures dans le dossier images/ :**
  

  1. images/capture_execution.png
     -> Capture du terminal apres bash scripts/analyse.sh
     -> Doit montrer les 4 graphiques generes et le rapport
     

  3. images/capture_rapport.png
     -> Capture du contenu de output/rapport.txt
     -> Commande : cat output/rapport.txt
     

  5. images/capture_graphique_barres.png
     -> Capture des 2 diagrammes en bandes generes
     -> Ouvrir les PNG dans un visualiseur si disponible
     

  7. images/capture_graphique_circulaire.png
     -> Capture des 2 diagrammes circulaires generes
     

  9. images/capture_jupyter.png
     -> Capture du RAPPORT.ipynb ouvert dans le navigateur
     -> Doit montrer les cellules executees avec les graphiques


  ## 7. RESULTATS ATTENDUS

  ```
  Apres execution, vous devez voir dans output/ :
    rapport.txt                    -> rapport texte complet
    graph_barres_temperatures.png  -> 4 barres par ville (temp)
    graph_barres_humidite_vent.png -> 3 barres par ville
    graph_circulaire_humidite.png  -> camembert humidite 3 villes
    graph_circulaire_nuages.png    -> camembert nuages 3 villes

  Contenu de rapport.txt :
    - Informations etudiant
    - Details meteo pour chaque ville (temp, humidite, vent...)
    - Liste des graphiques generes
    - Interpretation (ville la plus chaude, humide, etc.)
  ```

 ##  8. TECHNOLOGIES UTILISEES

  ```
  PowerShell (Windows)
    - Invoke-RestMethod : appel API REST OpenWeatherMap
    - ConvertTo-Json    : conversion en JSON
    - Out-File          : sauvegarde du fichier

  Bash (VM Ubuntu)
    - mkdir, ls, cat    : gestion des fichiers
    - pip3              : installation des dependances
    - python3           : lancement du script Python

  Python 3 (VM Ubuntu)
    - json              : lecture du fichier JSON
    - matplotlib        : generation des 4 graphiques
    - numpy             : calculs pour graphiques en bandes
    - datetime          : formatage des dates
    - sys, os           : gestion des arguments et chemins

  Jupyter Notebook (VM Ubuntu)
    - Visualisation interactive des donnees
    - Documentation avec cellules Markdown
    - Export des graphiques
  ```

  ## 9. SOURCE DES DONNEES

  ```
  API      : OpenWeatherMap
  URL      : https://openweathermap.org/api
  Endpoint : http://api.openweathermap.org/data/2.5/weather
  Params   : q={ville}&appid={cle}&units=metric&lang=fr
  Format   : JSON
  Limite   : 60 appels/minute (plan gratuit)
```
