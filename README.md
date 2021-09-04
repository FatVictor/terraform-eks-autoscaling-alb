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
## Deploy autoscaler

Run command:
_Please check if there is newer version from GitHub_
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml
```

Edit `cluser-autoscaler-autodiscover.yaml`:
- Replace `<YOUR AUTO SCALE ROLE ARN>` with output `auto_scale_role`
- Replace `<YOUR CLUSTER NAME>` with output `cluster_name`

Run command:

```
kubectl apply -f cluster-autoscaler-autodiscover.yaml
```

## Deploy Load Balancer

Edit `cluser-autoscaler-autodiscover.yaml`:
- Replace `<YOUR LOAD BALANCE ROLE ARN>` with output `load_balance_role`

Run commands:

```
kubectl apply -f aws-load-balancer-controller-service-account.yaml
```

```
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"
```
Add the eks-charts repository.
```
helm repo add eks https://aws.github.io/eks-charts
```
Update your local repo to make sure that you have the most recent charts.
```
helm repo update
```

run output command: `apply_load_balance`

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
