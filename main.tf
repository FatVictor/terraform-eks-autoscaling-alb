module "eks" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name = local.cluster_name
  cluster_version = local.cluster_version
  subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
  node_groups = {
    group-01 = {
      desired_capacity = local.desired_capacity
      max_capacity = local.max_capacity
      min_capacity = local.min_capacity
      disk_size = local.disk_size
      disk_type = "gp3"

      instance_types = [
        local.aws_instance_type
      ]
      capacity_type = "ON_DEMAND"
      additional_tags = {
        "k8s.io/cluster-autoscaler/enabled" = "true"
        "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
      }
    }
  }
}
