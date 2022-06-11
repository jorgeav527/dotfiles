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

