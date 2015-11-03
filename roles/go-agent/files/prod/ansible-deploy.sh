#!/bin/bash
(cd /opt/playbooks/hie-config && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Playbooks/$1 && git checkout group_vars && git checkout $1 && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Bahmni-Playbooks && git checkout group_vars && git checkout $1 && git pull --rebase)
cp -rf /opt/playbooks/hie-config/playbooks/* /opt/playbooks/FreeSHR-Playbooks/$1/
cp -rf /opt/playbooks/hie-config/chw-playbooks/* /opt/playbooks/FreeSHR-Bahmni-Playbooks/$1/
ansible-playbook "${@:2}"