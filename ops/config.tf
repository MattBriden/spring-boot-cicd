variable "env" {
  description = "Environment deploying to specified in the apply command"
  default = "whirlwind"
}

variable "profile" {
  description = "AWS credentials profile to use"
  default = "default"
}

variable "region" {
  description = "AWS region where the terraform will be run against"
  default = "us-east-1"
}

variable "github_token_secret_arn" {
  description = "ARN for GitHub token secret"
  default = "arn:aws:secretsmanager:us-east-1:891709250373:secret:github/access/token-KbzuHr"
}

variable "eks_cluster" {
  description = "EKS Cluster destination for application"
  default = {
    whirlwind = "test-springboot-pipeline-eks"
  }
}

variable "github_repo" {
  description = "GitHub repository to connect to CodeBuild"
  default = {
    whirlwind = "https://github.com/MattBriden/spring-boot-cicd"
  }
}
