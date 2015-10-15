#!/bin/bash
(cd /opt/playbooks/hie-config && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Playbooks && git checkout group_vars)
(cd /opt/playbooks/FreeSHR-Bahmni-Playbooks && git checkout group_vars)
(cd /opt/playbooks/FreeSHR-Playbooks && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Bahmni-Playbooks && git pull --rebase)
cp -rf /opt/playbooks/hie-config/playbooks/* /opt/playbooks/FreeSHR-Playbooks/
cp -rf /opt/playbooks/hie-config/chw-playbooks/* /opt/playbooks/FreeSHR-Bahmni-Playbooks/
ansible-playbook "$@"