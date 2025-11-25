# eks-full-mastery 🚀

**Production-grade AWS EKS cluster built with Terraform + Kubernetes addons + NLB + autoscaling**

This repository demonstrates real-world, production-level EKS competency, including:

- **Terraform-provisioned EKS cluster** (VPC, subnets, node groups, OIDC)
- **AWS Load Balancer Controller** (ALB/NLB integration)
- **Metrics Server**
- **Cluster Autoscaler** with IRSA + ASG auto-discovery
- **NGINX application** exposed through an internet-facing **NLB** with **pod-IP targets**
- Fully validated with healthy AWS Target Groups and **HTTP 200 OK** responses

---

## 🏗️ Architecture (High-Level)

```mermaid
flowchart TB
  user((User))
  dns[Public NLB DNS]
  nlb[NLB - Internet Facing]
  tg[Target Group - Pod IP Targets]
  subnets[Private Subnets]
  nodes[EKS Managed Node Group]
  pods[Nginx Pods]
  eks[EKS Control Plane]

  user --> dns --> nlb --> tg --> pods
  pods --> nodes --> subnets
  eks --- nodes
AWS EKS Project: Terraform + Load Balancers + Autoscaling

This lab demonstrates a fully automated, production-grade EKS deployment using:

🔹 Terraform (Infrastructure as Code)

Custom VPC with public/private subnets

IAM Roles for Service Accounts (IRSA)

EKS cluster + managed node group

Automated OIDC + IAM integration

🔹 Kubernetes Addons

AWS Load Balancer Controller

Metrics Server

Cluster Autoscaler with auto-discovered ASGs

🔹 Application Deployment

NGINX deployment on EKS

Exposed using Service: LoadBalancer

Controller provisions an internet-facing NLB

Pod IPs registered as healthy targets

Verified via public NLB DNS (HTTP 200)

🔹 Skills Demonstrated

End-to-end EKS provisioning using Terraform

Kubernetes addon lifecycle management

AWS NLB/ALB integration

Autoscaling with ASG + Cluster Autoscaler

Deep AWS troubleshooting: ELB, TGs, health checks

Complete build → validate → teardown workflow
This project provisions a fully automated, production-grade Amazon EKS environment using Infrastructure as Code and Kubernetes best practices.

---
