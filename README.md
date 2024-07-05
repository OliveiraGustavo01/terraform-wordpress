# Terraform WordPress on ECS

This repository contains Terraform code to set up a WordPress environment using Amazon ECS (Elastic Container Service), Amazon EFS (Elastic File System), Amazon RDS (Relational Database Service), Amazon CloudFront, AWS WAF, and Redis.

## Features

- **ECS Cluster**: Sets up an ECS cluster to host the WordPress application.
- **EFS**: Uses Amazon EFS for persistent storage of WordPress files.
- **RDS**: Configures an RDS database instance for the WordPress backend.
- **ALB (Application Load Balancer)**: Utilizes an ALB to distribute traffic to the ECS service.
- **Redis**: Sets up a Redis cache to enhance WordPress performance.
- **CloudFront**: Implements a CloudFront CDN for global content distribution.
- **WAF (Web Application Firewall)**: Configures AWS WAF to protect the application from common web threats.
- **ACM Certificate**: Requires a valid ACM certificate to enable HTTPS.

## Prerequisites

- **AWS Account**: Ensure you have an active AWS account.
- **Terraform**: Install Terraform on your local machine.
- **AWS CLI**: Configure the AWS CLI with your credentials.
- **ACM Certificate**: A valid ACM certificate must be available in your AWS account in the specified region.

