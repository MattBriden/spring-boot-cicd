# Spring Boot CICD Project
This is an example project of how to deploy a Spring Boot application onto an EKS cluster

## Pre-Requisites
This project assumes that there is already an EKS cluster available in the AWS environment.

## Steps

Deploy the Terraform code found in the `ops` directory. Instructions on how to do that can be found [here](./ops/README.md).

Once the Terraform is deployed the CodeBuild role needs added to the Kubernetes ConfigMap. The ConfigMap should ultimately look like the below.
```
apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: default-arn
      username: default-name
    - groups:
      - system:masters
      rolearn: CODEBUILD_ARN_HERE
      username: deployjob
kind: ConfigMap
metadata:
  creationTimestamp: "2022-04-08T14:20:05Z"
  name: aws-auth
  namespace: kube-system
  resourceVersion: "resourceVersion"
  uid: uuid
```

