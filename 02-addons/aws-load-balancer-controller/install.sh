#!/usr/bin/env bash
set -euo pipefail

CLUSTER="isovault-eks-lab"
REGION="us-east-1"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"

# 1) Create IAM policy
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy-${CLUSTER} \
  --policy-document file://iam-policy.json \
  || echo "Policy may already exist."

POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/AWSLoadBalancerControllerIAMPolicy-${CLUSTER}"

# 2) Create IRSA service account
eksctl create iamserviceaccount \
  --cluster ${CLUSTER} \
  --region ${REGION} \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn ${POLICY_ARN} \
  --override-existing-serviceaccounts \
  --approve

# 3) Install controller with Helm
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=${CLUSTER} \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=${REGION} \
  --set vpcId=$(aws eks describe-cluster --name ${CLUSTER} --region ${REGION} \
      --query "cluster.resourcesVpcConfig.vpcId" --output text)

kubectl rollout status deployment/aws-load-balancer-controller -n kube-system
