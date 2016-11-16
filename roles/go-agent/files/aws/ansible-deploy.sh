#!/bin/bash
(cd /opt/playbooks/FreeSHR-Playbooks/$1 && git checkout $1 && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Bahmni-Playbooks/$1 && git checkout $1 && git pull --rebase)
(cd /opt/playbooks/SHR-AWS-Playbooks/master && git checkout master && git pull --rebase)
cp /opt/playbooks/SHR-AWS-Playbooks/master/ansible.cfg /opt/playbooks/FreeSHR-Playbooks/$1/
cp /opt/playbooks/SHR-AWS-Playbooks/master/group_vars/shr_launch_key.pem /opt/playbooks/FreeSHR-Playbooks/$1//group_vars/
ansible-playbook "${@:2}"