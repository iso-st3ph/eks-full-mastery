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

---

## AWS EKS Project: Terraform + Load Balancers + Autoscaling

This lab demonstrates a fully automated, production-grade EKS deployment using:

### 🔹 Terraform (Infrastructure as Code)
- Custom VPC with public/private subnets
- IAM Roles for Service Accounts (IRSA)
- EKS cluster + managed node group
- Automated OIDC + IAM integrations

### 🔹 Kubernetes Addons
- **AWS Load Balancer Controller** (provisions internet-facing NLB/ALB)
- **Metrics Server** for resource metrics
- **Cluster Autoscaler** with IRSA + ASG auto-discovery

### 🔹 Application Deployment
- NGINX deployment running on EKS
- Exposed using `Service: LoadBalancer`
- Controller provisions an **internet-facing NLB**
- Pod IPs registered as **healthy targets** in the AWS Target Group
- Verified with HTTP 200 responses via public NLB DNS

### 🔹 Skills Demonstrated
- Production EKS provisioning with Terraform
- Kubernetes addon lifecycle management
- Load balancer integration (ALB/NLB)
- IAM security (IRSA)
- Autoscaling (Cluster Autoscaler + ASGs)
- Debugging ELB, target groups, health checks
- End-to-end workload deployment and teardown

---
