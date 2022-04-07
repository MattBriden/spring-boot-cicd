module "ecr" {
  source = "./modules/ecr"
}

module "build" {
  source = "./modules/build"

  env = var.env
  github_token_secret_arn = var.github_token_secret_arn
  ecr_repo = module.ecr.ecr_url
  eks_cluster = lookup(var.eks_cluster, var.env)
  github_repo = lookup(var.github_repo, var.env)
}
