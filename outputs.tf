output "connect_to_eks" {
  value = "aws eks --region ${data.aws_region.current.id} update-kubeconfig --name ${data.aws_eks_cluster.cluster.name}"
}

output "grant_access" {
  value = "kubectl edit -n kube-system configmap/aws-auth"
}

output "cluster_name" {
  value = data.aws_eks_cluster.cluster.name
}

output "auto_scale_role" {
  value = aws_iam_role.auto_scale_role.arn
}

output "load_balance_role" {
  value = aws_iam_role.load_balance_role.arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "region_id" {
  value = data.aws_region.current.id
}

