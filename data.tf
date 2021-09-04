data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "tls_certificate" "cluster" {
  url = module.eks.cluster_oidc_issuer_url
}

data "aws_vpc" "current" {
  id = module.vpc.vpc_id
}
