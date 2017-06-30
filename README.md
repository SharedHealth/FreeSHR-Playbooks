FreeSHR-Playbooks
=================

This repository contains the playbooks to provision all systems of HIE. This guide will explain how to setup local HIE environment.

### Prerequisites

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](http://docs.vagrantup.com/v2/installation/index.html)
* [Ansible](https://www.ansible.com/) 2.x

Clone the FHIR-Playbooks repo.

#### Structure
###### Inventories:-
The inventories folder contains the information about where each of the services will be installed. Each Service can be installed on a single host or multiple hosts in case of multi-node server. For each environment there will be a separate file. 
 
###### group_vars:-
The group_vars folder contains the different parameters for each services which are configurable depending on the enviornment. E.g.:- SHR port might be different in two different environment.

#### Provisioning Terminology-Server
Terminology server is a registry of all the Concepts, Reference-Terms and Medicines.

###### Start a vagrant box
A vagrant box should be created with the same IP given in `inventories/local` for tr-server i.e. 192.168.33.21.

###### Download the TR-Server RPM and other required omods
* Put the tr-server RPM into `/tmp/` folder. Under development version can be built locally or can be downloaded from CI-Server. Released versions are published to [github-releases](https://github.com/SharedHealth/Terminology-Server/releases). 
* Download the OpenMRS Atomfeed-omod and put it into `/tmp/` folder.
```
wget https://oss.sonatype.org/content/repositories/snapshots/org/ict4h/openmrs/openmrs-atomfeed-omod/2.5.5-SNAPSHOT/openmrs-atomfeed-omod-2.5.5-20161107.094541-4.jar -O /tmp/openmrs-atomfeed-2.5.5-SNAPSHOT.omod
```
* Download the Web Services rest omod and put it into `/tmp/` folder.
```
wget https://modules.openmrs.org/modulus/api/releases/1547/download/webservices.rest-2.17.omod -O /tmp/webservices.rest-2.17.omod
```
* Download the openmrs legacyui omod and put it into `/tmp/` folder. This is applicable from TR-2.7 onwards.
```
wget https://modules.openmrs.org/modulus/api/releases/1594/download/legacyui-1.3.1.omod -O /tmp/legacyui-1.3.1.omod
```

##### Setup ansible group_vars
* replace FreeSHR-Playbooks/group_vars/all with FreeSHR-Playbooks/group_vars/all_example
* create a dummy ansible vault pass file in your user home folder.
```
touch ~/.vaultpass.txt
```

##### Start Provision
* Go to the folder where you cloned the repository.
* Run the ansible-playbook command.
```
ansible-playbook tr.yml --tags tr-server -i inventories/local --extra-vars="rpm=/tmp/bdshr-terminology-server-2.7-1.noarch.rpm" --extra-vars="atomfeedomod=/tmp/openmrs-atomfeed-2.5.5-SNAPSHOT.omod" --extra-vars="restomod=/tmp/webservices.rest-2.17.omod" --extra-vars="uiomod=/tmp/legacyui-1.3.1.omod" -k -vvvv 
```
Enter the password as `vagrant` when asked. This is the default password for vagrant user.
 
##### Tr-Server Initial setup.
* Go to your browser and access [http://192.168.33.21:9080/openmrs](http://192.168.33.21:9080/openmrs). This will take you to initial setup screen of openmrs.
* Choose English as as the preferred language.
* Choose `Advanced` as the installation type.

* Installation wizard: step 1
    * choose "yes" for "Do you currently have an OpenMRS database installed .... ?" enter database name "terminologies".
    
* Installation wizard: step 2
    * choose "yes" for "Do you need OpenMRS to automatically create the tables ... ?" 
    * choose "no" for "Do you want to also add demo data to your database.... ?"
    * choose "Yes" for "Do you currently have a database user other than root .... ?".  By default, a username "terminologies" would be already filled in for the username. 

* Installation wizard: step 3
    * Do you want updates to the database to be automatically applied on startup when a new web application is deployed? - YES

* Installation wizard: step 4
    * choose a password for "admin" user. note this down.
* Installation wizard: skip step 5, optionally fill in details
* review installation instructions and proceed. The wizard should "create openmrs tables", "Add OpenMRS core data" and "Update the database" before redirecting you to the login page.

The TR-Server will be up and running after this. It will be generate feeds for newly created concepts/reference-terms/medicines once you have deployed TR-Feed omod.
 
Below are the steps to deploy TR-Feed-Omod.
* Put the TR-Feed omod into `/tmp/` folder. Under development version can be built locally or can be downloaded from CI-Server. Released versions are published to [github-releases](https://github.com/SharedHealth/openmrs-module-freeshr_terminology_feed/releases).
* Go to Freeshr-Playbooks folder.
* Run the ansible command
```
ansible-playbook tr.yml -t tr-feed-server -i inventories/local --extra-vars="trfeedomod=/tmp/freeshr-terminology-feed-2.7-SNAPSHOT.omod" -k -vvvv
```

Verify that `FreeSHR terminology service feed module` is present and running in openmrs=>admin=>manage modules. 
