# eks-full-mastery 🚀  
**Production-grade AWS EKS cluster built with Terraform + Kubernetes addons + NLB + autoscaling**

This repository demonstrates real-world, production-level EKS competency, including:

- Terraform-provisioned EKS cluster (VPC, subnets, node groups, OIDC)
- AWS Load Balancer Controller (ALB/NLB integration)
- Metrics Server
- Cluster Autoscaler with IRSA + ASG auto-discovery
- NGINX application exposed through an internet-facing NLB with **pod-IP targets**
- Fully validated with healthy AWS Target Groups and **HTTP 200 OK** responses

---

## 🏗️ Architecture (High-Level)

```mermaid
flowchart TB
  user((User))
  dns[Public NLB DNS]
  nlb[NLB - Internet Facing]
  tg[Target Group<br/>Pod IP Targets]
  nodes[EKS Managed Node Group]
  pods[Nginx Pods]
  eks[EKS Control Plane]

  user --> dns --> nlb --> tg --> pods
  pods --> nodes --> eks
