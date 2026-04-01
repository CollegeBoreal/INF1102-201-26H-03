le package ansible n’existe pas (ou plus) directement sur Chocolatey. Et même quand il existait, Ansible n’est pas conçu pour tourner nativement sur Windows.

Solution recommandée (la vraie bonne méthode)

Ansible fonctionne sur Linux. Sur Windows, tu dois passer par :

🔹 Option 1 — WSL (Windows Subsystem for Linux) → ⭐ MEILLEUR CHOIX
Installe WSL :

wsl --install

Redémarre ton PC
Ouvre Ubuntu (installé automatiquement)
Installe Ansible :


wsl

sudo apt update
sudo apt install ansible-core -y
