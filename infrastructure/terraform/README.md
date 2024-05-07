# ANSIBLE 

This folder contains .tf used for the infrastructure setup and deployment. \
**_IMPORTANT: Provisioning and deploying this infrastructure will incur costs for your AWS account. Please make sure to 'detroy' your resources if they are not being used._**

## Configuration

Prior to deploying your infrastructure you need to do the followin steps:

### 1. Set AWS credentials as environment variables with all necessary permissions.
```bash
 export AWS_ACCESS_KEY_ID=${your_aws_access_key}
 export AWS_SECRET_ACCESS_KEY=${your_aws_secret_access_key}
```

### 2. Create keypair

Go to your AWS Account, into EC2 go to Key Pairs (side panel) and create a new keypair called **'TF_EnergyConsumption'**. This key will be used to connect to the EC2 instance though SSH and deploy the applications.

*Once all the previous steps have been completed, you can deploy your infrastructure.*


## Terraform Folder Structure

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

## Deploying the Infrastructure

To deploy the infrastructure, run the following commands.

1. Initiate your terraform states
```bash
terraform init
```

2. Check everything is setup correctly
```bash
terraform plan
```

3. (If everythin is fine) Deploy your infrastructure
```bash
terraform deploy -auto-approve
```

4. Destroy your infrastructure (If you don't want to keep your infrastucture up)
```bash
terraform destroy -auto-approve
```