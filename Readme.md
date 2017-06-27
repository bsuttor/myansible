My Ansible configuration
========================

This project is used to configure my personal computer (on Ubuntu).


Testing
-------

Docker is used to test this environment

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
1. Set your local settings, create config.json file.

    {
        "username": "my_local_username",
        "github_username": "my_github_username",
        "dropbox_username": "my_dropbox_username.",
        "dropbox_password": "12345",
    }


2. Launch

    $ make apply
