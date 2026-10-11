# Terraform AWS Infrastructure Setup

## Project Objective
Provision AWS infrastructure using Terraform (Infrastructure as Code): create a VPC, a subnet, launch an EC2 instance, and connect to it through SSH.

## Tools Used
- Terraform
- AWS EC2
- AWS VPC
- AWS CLI
- VS Code

## Resources Created (8)
- VPC (10.0.0.0/16)
- Public Subnet (10.0.1.0/24)
- Internet Gateway
- Route Table and Route Table Association
- Security Group (SSH port 22)
- Key Pair
- EC2 Instance (Amazon Linux 2023, t3.micro)

## Steps Performed
1. Installed Terraform and configured AWS CLI with an IAM user
2. Wrote the infrastructure code in `main.tf`
3. Ran `terraform init`, `terraform validate` and `terraform plan`
4. `terraform apply` created 8 resources in ap-south-1 (Mumbai)
5. Connected to the EC2 instance using SSH
6. `terraform destroy` removed all resources

## Commands Used
terraform init
terraform validate
terraform plan
terraform apply
ssh -i terraform-key ec2-user@<public_ip>
terraform destroy

## Screenshots
Screenshots of plan output, apply output, VPC, subnet, EC2 instance, SSH connection and destroy output are included in this repository.

## Learning Outcomes
- Infrastructure as Code with Terraform
- Terraform workflow: init, plan, apply, destroy
- Creating VPC, subnet and EC2 using code
- Secure SSH access using key pairs

## Author
Smarika Choudhary
