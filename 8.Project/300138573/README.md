=== Rapport final d’analyse des logs ===

1. Objectif
Ce projet a pour objectif d’analyser un fichier de journalisation (log) afin d’identifier les adresses IP les plus actives, les URLs les plus consultées et les codes de statut HTTP retournés par le serveur.

2. Méthode
L’analyse a été réalisée à l’aide de deux scripts :
- un script Bash principal pour lancer le traitement
- un script Python pour lire le fichier data/sample.log, extraire les informations importantes et générer automatiquement ce rapport

Les éléments analysés sont :
- l’adresse IP source
- l’URL demandée
- le code de statut HTTP

3. Résultats obtenus

Top 3 adresses IP les plus actives :
- 192.168.1.10 : 4 requêtes
- 192.168.1.11 : 2 requêtes
- 192.168.1.12 : 2 requêtes

Top 3 URLs les plus consultées :
- /index.html : 4 accès
- /login : 2 accès
- /products : 2 accès

Répartition des codes de statut HTTP :
- 200 : 7 fois
- 302 : 1 fois
- 404 : 1 fois
- 500 : 1 fois

4. Analyse des résultats
L’adresse IP 192.168.1.10 est la plus active dans ce fichier log avec 4 requêtes. Cela montre qu’il s’agit du client le plus présent dans l’échantillon observé.

L’URL la plus visitée est /index.html avec 4 accès, ce qui indique qu’il s’agit probablement de la page principale du site.

Le code HTTP 200 apparaît 7 fois, ce qui signifie que la majorité des requêtes ont été traitées avec succès par le serveur.

Le code 302 apparaît 1 fois, ce qui correspond à une redirection, probablement après une tentative de connexion sur /login.

Le code 404 apparaît 1 fois, ce qui indique qu’une ressource demandée n’a pas été trouvée sur le serveur.

Le code 500 apparaît 1 fois, ce qui révèle une erreur interne du serveur. Même si cette erreur ne se produit qu’une seule fois, elle doit être surveillée car elle peut indiquer un problème applicatif ou serveur.

5. Conclusion
Cette analyse montre que le site répond correctement dans la majorité des cas, puisque le code 200 est dominant. Cependant, la présence des codes 404 et 500 prouve qu’il existe quelques anomalies à surveiller.

Le projet démontre l’utilisation combinée de Bash et Python pour automatiser l’analyse d’un fichier log et générer un rapport texte clair et exploitable.
