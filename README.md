# eks-full-mastery 🚀
**Production-grade AWS EKS cluster built with Terraform + core Kubernetes addons + NLB + autoscaling demos**

This repo demonstrates full, real-world EKS competency:
- Terraform-provisioned EKS cluster (VPC + subnets + node groups + OIDC)
- AWS Load Balancer Controller (ALB/NLB support)
- Metrics Server
- Cluster Autoscaler with IRSA
- Nginx app exposed through an internet-facing **NLB with pod-IP targets**
- End-to-end validation with healthy target groups and HTTP 200 responses

---

## Architecture (high-level)

```mermaid
flowchart TB
  user((User))
  dns[Public NLB DNS]
  nlb[NLB - internet-facing]
  tg[Target Group - IP targets: Pod IPs]
  subnets[Private Subnets]
  nodes[EKS Managed Node Group]
  pods[Nginx Pods]
  eks[EKS Control Plane]

  user --> dns --> nlb --> tg --> pods
  pods --> nodes --> subnets
  eks --- nodes
