#!/usr/bin/env bash
set -euo pipefail
CLUSTER="isovault-eks-lab"
REGION="us-east-1"

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"

cat > ca-policy.json <<'EOF'
{
  "Version": "2012-10-17",
  "Statement": [
    { "Effect": "Allow", "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ], "Resource": "*" }
  ]
}
EOF

aws iam create-policy \
  --policy-name ClusterAutoscalerPolicy-${CLUSTER} \
  --policy-document file://ca-policy.json \
  || echo "Policy may exist."

POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/ClusterAutoscalerPolicy-${CLUSTER}"

eksctl create iamserviceaccount \
  --cluster ${CLUSTER} \
  --region ${REGION} \
  --namespace kube-system \
  --name cluster-autoscaler \
  --attach-policy-arn ${POLICY_ARN} \
  --override-existing-serviceaccounts \
  --approve

ROLE_ARN=$(aws iam get-role --role-name eksctl-${CLUSTER}-addon-iamserviceaccount-kube-system-cluster-autoscaler \
  --query Role.Arn --output text)

sed "s|REPLACE_WITH_ROLE_ARN|${ROLE_ARN}|g" values.yaml > values.rendered.yaml

helm upgrade --install cluster-autoscaler autoscaler/cluster-autoscaler \
  -n kube-system -f values.rendered.yaml

kubectl rollout status deployment/cluster-autoscaler -n kube-system
