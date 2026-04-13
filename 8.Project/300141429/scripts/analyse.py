import sys
import json

data_file = sys.argv[1]
output_file = sys.argv[2]

with open(data_file, 'r') as f:
    data = json.load(f)

taux = data["rates"]["USD"]
date = data["date"]

with open(output_file, 'w') as f:
    f.write("Rapport de taux de change CAD → USD\n")
    f.write("=================================\n\n")
    f.write(f"Date : {date}\n")
    f.write(f"Taux : 1 CAD = {taux} USD\n")

print("Analyse terminée")
