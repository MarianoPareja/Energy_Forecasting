# Energy Consumption Forecasting

This project aims to forecast the energy consumption of the different regions of Denmark, allowing ML-driven decisions to 
allocate resources efficiently.

## Table of Content

- [ML Lifecycle](#ml-lifecycle)
- [Infrastructure](#infrastructure)
    - [Architecture](#architecture)
    - [Build with Terraform](#build-with-terraform)
    - [Configure with Ansible](#configure-with-ansible)
- [Project Structure](#project-structure)
- [Main Stack](#main-stack)
- [User Interface](#user-interface)

## ML Lifecycle
The ML Lifecycle uses batch processing with an FTI(Feature-Training-Inference) methodoloy, allowing to decouple the different components of this pipeline, sticking to good MLOps practices. Also a monitoring step to calculate the error of the predictions on a hourly basis.

The data is served by two UIs or via REST APIs.

<img src="./assets/images/ml-lifecycle.png" />

## PROJECT STRUCTURE
The project main structure is as follows:
```
├── README.md                       -> Lorem Ipsum is simply dummy text of the printing and typesetting industry  
├── .github/workflows               -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── CI/CD Pipelines             -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
├── infastructure                   -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── ansible                     -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   │   ├── group_vars              -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   │   ├── playbooks               -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   │   └── hosts.ini               -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── terraform                   -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   │   ├── modules
│   │   ├── xxx
│   │   └── xxx
├── src               
│   ├── airflow                     -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── app-api                     -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── app-frontend                -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── app-monitoring              -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── batch-prediction-pipeline   -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── deploy                      -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── feature-pipeline            -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
│   ├── training-pipeline           -> Lorem Ipsum is simply dummy text of the printing and typesetting industry
```

## Infrastructure

### Architecture 
<img src="./assets/images/architecture-diagram.png" />

### Build with Terraform 


### Configure with Ansible



## Main Stack

### Frontend
- [Streamlit](https://streamlit.io/) - The UI to visualize data metrics and predictions

### Backend
- [FastAPI](https://fastapi.tiangolo.com/) - The API to communicate with website application

### MLOps
- [Airflow](https://airflow.apache.org/) - Scheduling, managing and running the different pipelines
- [Hopsworks](https://www.hopsworks.ai/) - The feature store used to versionize the data
- [Weights&Biases](https://wandb.ai/site) - Logging and saving models metrics and model registry

### DevOps
- [GitHubs Actions](https://github.com/features/actions) - The CI/CD Pipeline
- [Docker / Docker-Compose](https://www.docker.com/) - Contarize components
- [Terraform](https://www.terraform.io/) - Provision and manage resources in the AWS
- [Ansible](https://www.ansible.com/) - Automate configuration of AWS resources




## User Interface
Two different webpages UI were built, the fisrt one for visualizing the forecasting data of the differents zones, while the other allows to compare the predicted data with the truth data collected each hour.