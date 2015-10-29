#!/bin/bash
(cd /opt/playbooks/FreeSHR-Playbooks && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Bahmni-Playbooks && git pull --rebase)
([ -d "/opt/playbooks/development/FreeSHR-Playbooks" ] && cd /opt/playbooks/development/FreeSHR-Playbooks && git pull --rebase)
([ -d "/opt/playbooks/development/FreeSHR-Bahmni-Playbooks" ] && cd /opt/playbooks/development/FreeSHR-Bahmni-Playbooks && git pull --rebase)
ansible-playbook "$@"