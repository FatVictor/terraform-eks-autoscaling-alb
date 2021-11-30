## Requirements

- Install terraform
- Install AWS CLI
- Install kubectl
- Configure AWS account
  ```aws configure```

## Create EKS Cluster

Edit variables in file:

```
locals.tf
```

Run Terraform:

```
terraform init
terraform apply
```

## Connect to your cluster

Check your output for variable:

```
connect_to_eks
```

Check that there is a node that is `Ready`:

```
$ kubectl get nodes
NAME                                       STATUS   ROLES    AGE     VERSION
ip-10-0-2-190.us-west-2.compute.internal   Ready    <none>   6m39s   v1.14.8-eks-b8860f
```

## Grant access other account to see cluster in AWS

Run command:

```
kubectl edit -n kube-system configmap/aws-auth
```

Add below info under data:
```
  mapUsers: |
    - userarn: arn:aws:iam::<account no>:user/<username>
      username: <username>
      groups:
        - system:masters
```


## Deploy autoscaler

Run command:
_Please check if there is newer version from GitHub_

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.2/components.yaml
```

Edit `autoscale.yaml`:

- Replace `<YOUR AUTO SCALE ROLE ARN>` with output `auto_scale_role`
- Replace `<YOUR CLUSTER NAME>` with output `cluster_name`

Run command:

```
kubectl apply -f autoscale.yaml
```

## Deploy Load Balancer

Edit `alb.yaml`: 

- Replace `<YOUR LOAD BALANCE ROLE ARN>` with output `load_balance_role`
- Replace `<YOUR CLUSTER NAME>` with without `cluster_name`
- Replace `<YOUR CLUSTER REGION>` with output `region_id`
- Replace `<YOUR CLUSTER VPC ID>` with output `vpc_id`

Run commands:

```
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml
```
Wait for deployment is completed
```
kubectl get deployment -n cert-manager cert-manager-webhook
```
Deployment ALB
```
kubectl apply -f alb.yaml
```

Verify that the controller is installed.

```
kubectl get deployment -n kube-system aws-load-balancer-controller
```

Test

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/examples/2048/2048_full_latest.yaml
```

Then clean up once you've done

```
kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/examples/2048/2048_full_latest.yaml
```

## Reporting bugs and contributing

- Want to report a bug or request a feature? Please open [an issue](https://github.com/FatVictor/terraform-eks-autoscaling-alb/issues/new).
- Want to help us build project? Please submit your pull request


## Reference

alb.yml is a custom version of https://github.com/kubernetes-sigs/aws-load-balancer-controller/tree/main/docs/install
autoscale.yaml is a custom version of https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml
