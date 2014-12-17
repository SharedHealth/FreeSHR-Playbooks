FreeSHR-Playbooks
=================

TODO

* Start cassandra after installing
* Add bdshr user to sudoers with nopasswd in the bahmni site
* Refactor scripts to use handlers instead of tasks where applicable



To install cassandra nodes run -
* update inventory - cassandra.hosts
* update cassandra.yaml template
* ansible-playbook -k -i cassandra.hosts db-nodes.yml --tags "setup"


To install opscenter server run -
* update inventory - opscenter.hosts
* ansible-playbook -k -i opscenterserver.hosts db-nodes.yml --tags "opscenter-server"

To install opscenter agents run -
* ansible-playbook -k -i cassandra.hosts db-nodes.yml --tags "opscenter-agents"

To create a bdshr user on VM - 
* add VM address to scaleworks.hosts
* ansible-playbook -k -i scaleworks.hosts db-nodes.yml --tags "create-user"

