#!/bin/bash
(cd /opt/playbooks/FreeSHR-Playbooks && git pull --rebase)
(cd /opt/playbooks/FreeSHR-Bahmni-Playbooks && git pull --rebase)
ansible-playbook "$@"