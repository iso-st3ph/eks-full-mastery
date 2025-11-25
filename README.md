eks-full-mastery 🚀

Production-grade AWS EKS cluster built with Terraform + Kubernetes addons + NLB + autoscaling

This repository demonstrates real-world, production-level EKS competency, including:

Terraform-provisioned EKS cluster (VPC, subnets, node groups, OIDC)

AWS Load Balancer Controller (ALB/NLB integration)

Metrics Server

Cluster Autoscaler with IRSA + ASG auto-discovery

NGINX application exposed through an internet-facing NLB with pod-IP targets

Fully validated with healthy Target Groups and HTTP 200 OK responses

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

This project provisions a fully automated, production-grade Amazon EKS environment using Infrastructure as Code and Kubernetes best practices.

🔹 Terraform (Infrastructure as Code)

Custom VPC with public/private subnets

EKS cluster + managed node group

IAM Roles for Service Accounts (IRSA)

Automatic OIDC provider creation

Node group configured for Cluster Autoscaler tags

Modular, reusable Terraform structure

🔹 Kubernetes Addons
AWS Load Balancer Controller

Enables Kubernetes Services to create ALBs / NLBs

Automatically provisions NLB for the NGINX Deployment

Pod IPs registered into Target Groups

Verified working with healthy targets

Metrics Server

Enables HPA + Autoscaler metrics

Required for autoscaling functionality

Cluster Autoscaler (with IRSA)

Uses IAM permissions tied to the CA service account

Auto-discovers ASGs created by Terraform

Scales the EKS node group automatically

Leader election + healthy logs validated

🔹 Application Deployment

NGINX Deployment with 2 replicas

Exposed using a LoadBalancer Service

AWS Load Balancer Controller creates an internet-facing NLB

Target Group:

Uses pod IP targets

Shows healthy target states

Allows public access through the NLB DNS name

Example validation:
curl -I http://<nlb-dns-name>
HTTP/1.1 200 OK
Server: nginx

🔹 Skills Demonstrated

Production-ready EKS provisioning using Terraform

Kubernetes addon installation (Helm + kubectl)

Load balancer integration (ALB/NLB)

IRSA-based IAM security

Autoscaling using Cluster Autoscaler + ASGs

Debugging:

ELB/NLB provisioning

Target group health

IRSA permissions

Leader lock issues

End-to-end deployment + teardown lifecycle

eksctl delete cluster --name isovault-eks-lab --region us-east-1
terraform destroy -auto-approve

Verified:

No EKS clusters

No EC2 instances

No ASGs

No NLBs

No residual AWS costs

📚 Project Status

✔️ Fully functional
✔️ Tested end-to-end
✔️ Validated via NLB + TargetGroups
✔️ Real production-grade workflow
✔️ Safe to reproduce anytime