# Building the CodeBuild hook
The CodeBuild hook is deployed via terraform. Please ensure you have the most recent version of terraform installed. For simplicity a script is provided to execute the terraform commands.
### Deploy Resources Commands
Run the following command to deploy the CodeArtifact and CodeBuild resources to a particular environment.
```
spring-boot-cicd/ops $ ENV=whirlwind AWS_PROFILE=whirlwind AWS_REGION=us-east-1 ./terraform.sh apply
```
### Remove Resources Commands
To remove the resources from an AWS environment run the following command.
```
spring-boot-cicd/ops $ ENV=whirlwind AWS_PROFILE=whirlwind AWS_REGION=us-east-1 ./terraform.sh destroy
```
### Environment Variables
Below are the default values for all environment variables referenced in the Terraform script.

- ENV: test
- AWS_PROFILE: default
- AWS_REGION: us-east-1

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://releases.hashicorp.com/terraform/) | &gt;= 1.0.0, &lt; 1.1.0 |
| [aws](https://registry.terraform.io/providers/hashicorp/aws/latest) | &gt;= 3.64 |