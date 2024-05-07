# ANSIBLE
This folder container scripts to automate servers configuration.

## Configuration

### 1. Upload your keypair
```bash
mkdir {WORKDIR}/infrastructure/ansible/keys                                             # Create key folder
mv {KEYPAIR_PATH}/TF_EnergyConsumption.pem {workdir}/infrastructure/ansible/keys        # Upload your key
```

### 2. Configure API keys
There is a default file with all the necessary APIs keys
```bash 
cat {ANSIBLE_PATH}/inventories/dev/group_vars/secrets.default.yml >> secrets.test.yml    # Configure all the API keys in a new file    
ansible-vault encrypt {ANSIBLE_PATH}/inventories/dev/group_vars/secrets.enc.yml
```

### 3. Configure ansible-vault password
```bash
{your_ansible_password} >> {ANSIBLE_PATH}/inventories/dev/group_vars/secrets-key
```

### 4. Configure IP addresses
*This can be done after deploying your infrastructure, because public IP addresses for the servers are randomly assigned from a pool.*
Open the followin file: {ANSIBLE_PATH}/inventories/dev/hosts.ini and replaced the IP addresses.

### 5. Configurate servers.
Once all previous steps are correctly done, configure the servers running the following command:
```bash
ansible-playbook system.yml
```
*Configurations takes between 5-10 minutes*


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