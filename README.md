## **PROJET** 

Création d'un cluster EKS via Terraform

### How to setup ?

#### Initiate backend configuration

You need to create the backend configuration file (eg. config.s3.tfbackend) then you can run : `terraform init -backend-config="./config.s3.tfbackend"`

```py
region = "<region>"
bucket= "<bucket_name>"
key = "<filename>"
use_lockfile = <true / false>
```