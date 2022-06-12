# DOTFILES
Desktop configuration (MAC or UBUNTU 20.04)

## Create a user with Administrative Privileges (sudo). [📎](https://cloudcone.com/docs/article/how-to-create-a-user-on-ubuntu-20-04/)

1. `$ sudo adduser username`
2. `$ sudo usermod -aG sudo username`

## Installing Ansible on Ubuntu. [📎](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu)

1. `$ sudo apt update`
2. `$ sudo apt install software-properties-common`
3. `$ sudo add-apt-repository --yes --update ppa:ansible/ansible`
4. `$ sudo apt install ansible`

## After install Ubuntu 20.04
1. `sudo apt update && sudo apt upgrade -y`
2. Check if the system needs drivers
3. `sudo apt install ubuntu-restricted-extras -y`
4. `sudo apt install gnome-tweaks`
5. `sudo apt install chrome-gnome-shell`
6. Open firefox and install https://extensions.gnome.org/
7. Install grid workspaces https://askubuntu.com/questions/1232919/how-do-i-get-grid-workspaces-in-ubuntu-20-04


## install brave
1. `sudo apt install apt-transport-https curl`
2. `sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg`
3. `echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list`
4. `sudo apt update`
5. `sudo apt install brave-browser -y` --> https://brave.com/linux/

