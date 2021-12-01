module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "${local.cluster_name}-vpc"
  cidr = "10.0.0.0/16"
  azs = data.aws_availability_zones.available.names
  public_subnets = [
    "10.0.64.0/18",
    "10.0.128.0/18",
    "10.0.192.0/18"]
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}
