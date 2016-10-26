#!/bin/bash
(cd /opt/playbooks/FreeSHR-Playbooks/$1 && git checkout $1 && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Bahmni-Playbooks/$1 && git checkout $1 && git pull --rebase)
ansible-playbook "${@:2}"