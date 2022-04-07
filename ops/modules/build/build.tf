data "aws_secretsmanager_secret" "github_token" {
  arn = var.github_token_secret_arn
}

data "aws_secretsmanager_secret_version" "github_token_version" {
  secret_id = data.aws_secretsmanager_secret.github_token.id
}

resource "aws_codebuild_source_credential" "whirlwind_creds" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token = jsondecode(data.aws_secretsmanager_secret_version.github_token_version.secret_string)["token"]
}

resource "aws_codebuild_project" "springboot_code_build" {
  name = "${var.env}-springboot-api-build"
  build_timeout = "300"
  service_role  = aws_iam_role.codebuild_service_role.arn
  concurrent_build_limit = 1

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:3.0"
    type  = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  environment_variable {
    name  = "ECR_REPO"
    value = var.ecr_repo
  }

  environment_variable {
    name  = "EKS_CLUSTER"
    value = var.eks_cluster
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.env}-springboot-api-build-group"
      stream_name = "${var.env}-springboot-api-build-stream"
    }
  }

  source {
    type = "GITHUB"
    location = var.github_repo
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = "master"
}
