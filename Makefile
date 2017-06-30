


install:
	# todo: check if ansible is not installed
	sudo apt-get install -y software-properties-common
	sudo apt-add-repository -y ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install -y ansible
	sudo ansible-galaxy install jgkim.atom
	sudo ansible-playbook setup.yml -i hosts -c local -v --extra-vars "@config.json" #--ask-sudo-pass

apply:
	sudo ansible-playbook apply.yml -i hosts -c local -v --extra-vars "@config.json" #--ask-sudo-pass

build:
	docker-compose rm -f
	docker-compose build

up:
	docker-compose rm -f
	docker-compose up
