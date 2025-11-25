#!/usr/bin/env bash
set -euo pipefail
cd 01-terraform-eks
terraform destroy -auto-approve
