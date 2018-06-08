My Ansible configuration
========================

This project is used to configure my personal computer (on Ubuntu).

FYI, Dropbox is used to keep some configuration files as ~/.vimrc, ~/.zshrc, ~/.ssh/config, ... Therefore Dropbox is first package installed, and configuration are applied after.


Testing
-------

Docker / docker-compose are used to test this environment, you can start VNC local test env with:

    $ make up

vnc://localhost:5901 via VNC client.

The VNC password is password.


Install Ansible
---------------
First install git :

    $ sudo apt install git

Then clone myansible repo and go in it.

    $ git clone https://github.com/bsuttor/myansible
    $ cd myansible

And then, install ansible

    $ make install


Configure your computer
-----------------------
1. Add your id_rsa key on ~/.ssh folder

2. Set your local settings, create group_vars/all file.

    ---
    name: Benoît Suttor
    username: "{{ lookup('env','USER') }}"
    homepath: "{{ lookup('env','HOME') }}"
    atom_upgrade_all: True
    atom_packages:
      - atom-beautify
      - autocomplete-pyton
      - blame
      - editorconfig
      - hyperclick
      - language-ansible
      - language-docker
      - language-ini
      - language-puppet
      - language-robot-framework
      - linter
      - linter-flake8
      - linter-puppet-lint
      - linter-ui-default
      - project-manager
      - python isort
      - sort-lines
      - toogle-quotes
    bin_dir: /usr/local/bin
    github_username: "{{ lookup('env','HOME') }}"


3. Launch

    $ make apply


Todo after
----------

- Set your profile terminal
- Go to /opt/pythons:
  - Comments pythons (in buildout.cfg in parts) you do not needed.
  - $ python bootstrap.py
  - $ ./bin/buildout
- Configure your gnome-extensions
