# Terraform-Modules
Deploy a Containerized Application (Jupiter Website) with ECS using Terraform Modules


This repository contains Terraform code to deploy a containerized application (Jupiter Website) using Amazon Elastic Container Service (ECS) with Terraform modules.


# Prerequisites
AWS CLI configured with the required AWS credentials
Terraform v0.14 or later installed
A Docker image of your application (Jupiter Website) hosted in a container registry (Amazon ECR)


# Modules

The Terraform code is organized into the following modules:


route53: This module provisions a Route53 hosted zone and record sets for your domain.


vpc: This module provisions the required VPC and subnets for the application.


security_group: This module provisions security groups for the application, ALB, and NAT gateways.


nat_gateway: This module provisions NAT gateways for the private subnets.


ecs: This module provisions the ECS cluster, task definition, and service for the containerized application.


autoscaling_group: This module provisions an EC2 Auto Scaling group for the ECS cluster.


application_load_balancer: This module provisions an Application Load Balancer (ALB) to route traffic to the containerized application.


acm: This module provisions an AWS Certificate Manager (ACM) SSL certificate for securing traffic between clients and the ALB.


# Usage


Update the terraform.tfvars file with the values for your environment.


After the terraform apply command is successful, the ALB's DNS name will be displayed in the output. Access your Jupiter Website by navigating to the DNS name:

Outputs:

alb_dns_name = "your-alb-dns-name"


# PERSONAL PROJECT 

This project was initially developed as a personal project to learn and experiment with containerized applications, AWS ECS, and Terraform modules. Although it began as a personal endeavor and teaching purpose, the knowledge and experience gained from this project have proven invaluable in my professional work. As a result, I often reference this project when working on similar tasks or discussing best practices with colleagues in my job. The project demonstrates my ability to design, implement, and manage a containerized application deployment using AWS ECS and Terraform, making it a valuable resource for both personal growth and professional development.