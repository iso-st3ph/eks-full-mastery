### Deploy
terraform init
terraform apply

### Kubeconfig
aws eks update-kubeconfig --region us-east-1 --name isovault-eks-lab

### Verify
kubectl get nodes
kubectl get pods -A
