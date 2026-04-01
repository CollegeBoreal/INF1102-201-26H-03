le package ansible n’existe pas (ou plus) directement sur Chocolatey. Et même quand il existait, Ansible n’est pas conçu pour tourner nativement sur Windows.

Solution recommandée (la vraie bonne méthode)

Ansible fonctionne sur Linux. Sur Windows, tu dois passer par :

🔹option 1 — WSL
Installe WSL :

wsl --install

Redémarre ton PC
Ouvre Ubuntu (installé automatiquement)
Installe Ansible :

wsl

sudo apt update
sudo apt install ansible-core -y

🔹 Option 2 — Installer via Python (moins recommandé)

pip install ansible

⚠️ Mais :

Certaines fonctionnalités ne marcheront pas bien
Ce n’est pas officiellement supporté sur Windows
