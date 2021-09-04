resource "aws_iam_role" "auto_scale_role" {
  name_prefix = "${local.cluster_name}_autoscale_"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect: "Allow",
        Principal: {
          "Federated": aws_iam_openid_connect_provider.eks_cluster_iodc.arn
        },
        Action: "sts:AssumeRoleWithWebIdentity",
        Condition: {
          "StringEquals": {
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
          }
        }
      },
    ]
  })
}

resource "aws_iam_role" "load_balance_role" {
  name_prefix = "${local.cluster_name}_load_balance_"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect: "Allow",
        Principal: {
          "Federated":aws_iam_openid_connect_provider.eks_cluster_iodc.arn
        },
        Action: "sts:AssumeRoleWithWebIdentity",
        Condition: {
          "StringEquals": {
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      },
    ]
  })
}

resource "aws_iam_openid_connect_provider" "eks_cluster_iodc" {
  url = module.eks.cluster_oidc_issuer_url

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.cluster.certificates.0.sha1_fingerprint]
}
