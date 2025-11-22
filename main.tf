module "s3_backend" {
  source = "./modules/s3-backend"
  bucket_name = "terraform-state-bucket-asya"
  table_name  = "terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_name           = "lesson-5-vpc"
}

module "ecr" {
  source      = "./modules/ecr"
  ecr_name    = "lesson-8-ecr"
  scan_on_push = true
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = "lesson-7-eks"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
}

data "aws_eks_cluster" "eks" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "eks" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}


module "jenkins" {
  source             = "./modules/jenkins"
  cluster_name       = module.eks.cluster_name
  oidc_provider_arn  = module.eks.oidc_provider_arn
  oidc_provider_url  = module.eks.oidc_provider_url
  github_pat         = var.github_pat
  github_user        = var.github_user
  github_repo_url     = var.github_repo_url
  ecr_repository_url  = module.ecr.ecr_url
  depends_on         = [module.eks]
  providers          = {
    helm       = helm
    kubernetes = kubernetes
  }
}

module "argo_cd" {
  source              = "./modules/argo_cd"
  namespace           = "argocd"
  chart_version       = "5.46.4"
  github_repo_url     = var.github_repo_url
  github_user         = var.github_user
  github_pat          = var.github_pat
  app_target_revision = "lesson-8-9"
  depends_on = [module.eks]
  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
}
