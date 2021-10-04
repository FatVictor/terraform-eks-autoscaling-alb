locals {
  cluster_name = "testing_eks"
  cluster_version = "1.21"
  aws_instance_type = "t3a.medium"
  desired_capacity = 1
  max_capacity = 10
  min_capacity = 1
  disk_size = 50
  region = "ap-southeast-1"
}
