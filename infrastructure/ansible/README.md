# ANSIBLE
This folder container scripts to automate servers configuration.

## Folder Structure
```
├── README.md        
├── inventories
│   ├── development/production/staging
│   │   ├── hosts.ini                       <- Inventory file for dev/stag/prod servers
│   │   ├── group_vars                      <- Group variables
│   │   │   ├── credentials                 <- Secrets variables definition
│   │   │   ├── vars        
├── playbooks       
├── system.yml                              <- Master playbook
├── webserver.yml                           <- Playbook for webserver tier
├── mlserver.yml                            <- Playbook for ML server tier
```