## CREDENTIALS

Set credentials using the terminal

```bash
 export AWS_ACCESS_KEY_ID=${your_aws_access_key}
 export AWS_SECRET_ACCESS_KEY=${your_aws_secret_access_key}
```


## TERRAFORM FOLDER STRUCTURE 

```
├── README.md        
├── main.tf                     <- Master .tf file
├── variables.tf                
├── outputs.tf                  
├── modules                     <- Module for infrastructure
│   ├── network
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── output.tf
│   ├── compute
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── output.tf


```
