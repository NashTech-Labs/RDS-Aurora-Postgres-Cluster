# RDS-Aurora-Postgres-Cluster:
This Repository can be used for creating AWS RDS Aurora PostgresSQL  Cluster with one writer instance.

## Terraform `init` command:

First Run terraform init to install all modules required by this configuration.

        terrform init

## Export Variable required to apply the configuration:

         export TF_VAR_db_username=<db_username>
         export TF_VAR_db_password=<"db_password">
         export TF_VAR_access_key=<your_aws_access_key>
         export TF_VAR_secret_key=<your_aws_secret_key>

## Terrform `plan` command:

To Generates a speculative execution plan run terraform plan command.

        terrform plan

## Applying the terraform script:

        terraform apply


## You can destory the resource using below command :

        terraform destroy
