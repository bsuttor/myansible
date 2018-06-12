#!/usr/bin/make

install:
	# todo: check if ansible is not installed
	sudo apt-get install -y software-properties-common
	sudo apt-add-repository -y ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install -y ansible
	sudo ansible-galaxy install -r requirements.yml --ignore-errors
	sudo ansible-playbook setup.yml -i hosts -c local -v #--ask-sudo-pass

apply:
	sudo ansible-playbook apply.yml -i hosts -c local -v #--ask-sudo-pass

# sudo ansible-playbook apply.yml -i hosts -c local -v -t docker

build:
	docker-compose rm -f
	docker-compose build

up:
	docker-compose rm -f
	docker-compose up

test:
	sudo ansible-playbook apply.yml -i hosts -c local -v --syntax-check
