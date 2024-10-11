# Scalable and Highly Available WordPress Deployment on AWS Using Elastic Beanstalk, RDS, and Terraform

## Table of Contents
1. [Overview](#overview)
2. [AWS Architecture](#aws-architecture)
3. [Prerequisites](#prerequisites)
4. [Step 1: Manual Setup on AWS](#step-1-manual-setup-on-aws)
   - [IAM Role Creation](#iam-role-creation)
   - [Elastic Beanstalk Setup](#elastic-beanstalk-setup)
   - [Amazon RDS Setup](#amazon-rds-setup)
5. [Step 2: Automate with Terraform](#step-2-automate-with-terraform)
   - [Setup Instructions](#setup-instructions)
6. [Security Best Practices](#security-best-practices)
7. [Cleanup](#cleanup)
8. [Conclusion](#conclusion)
9. [Acknowledgments](#acknowledgments)

## Overview
This guide provides step-by-step instructions to deploy a **highly available, scalable, and secure WordPress website** on **AWS Elastic Beanstalk** with **Amazon RDS** for database management. This setup leverages **Terraform** for automation, ensuring that AWS best practices for security, scalability, and performance are followed. The architecture is designed to handle high traffic loads using a multi-AZ (Availability Zone) configuration for fault tolerance.

---

<img width="1012" alt="wp-diagram" src="https://github.com/user-attachments/assets/b54506cb-d622-475d-ba43-b47122abb630">

*Architecture Diagram*

## AWS Architecture Breakdown
- **Elastic Beanstalk**: Manages infrastructure provisioning, load balancing, scaling, and monitoring for the WordPress environment.
- **Amazon RDS**: Provides a highly available MySQL database with data redundancy in multiple availability zones.
- **Amazon S3**: Hosts static files and media uploads.
- **CloudWatch**: Monitors performance metrics such as CPU utilization and application health.
- **IAM Roles**: Implements the principle of least privilege to restrict permissions.

## Prerequisites
1. **AWS Account** with appropriate IAM permissions.
2. **AWS CLI** installed and configured.
3. **Terraform** installed on your local machine.

---

## Step 1: Manual Setup on AWS

### IAM Role Creation
1. **Create the Elastic Beanstalk Service Role**:
   - Navigate to the **IAM Console**, create a new role for **Elastic Beanstalk**.
   - Attach the `AWSElasticBeanstalkServiceRolePolicy`.
   - Name it `aws-elasticbeanstalk-service-role`.

2. **Create the EC2 Instance Role**:
   - Create another role for **EC2** and attach `AmazonS3FullAccess` and `CloudWatchAgentServerPolicy`.
   - Name it `aws-elasticbeanstalk-ec2-role`.

### Elastic Beanstalk Setup
1. **Create Application**:  
   - Go to **Elastic Beanstalk** in the AWS Console.
   - Create a new application named `wordpress-app` and select **PHP** as the platform.
   - Upload the **WordPress** `.zip` file (make sure to download and compress it from the official WordPress website).

2. **Environment Configuration**:
   - Set up an environment as a **Web server environment**.
   - Select **t3.micro** for the instance type.
   - Use **multi-AZ** for high availability (note that multi-AZ incurs additional costs).
   - Assign the IAM roles created earlier (`aws-elasticbeanstalk-service-role` and `aws-elasticbeanstalk-ec2-role`).

3. **Deploy the Application**:  
   - Follow the Elastic Beanstalk wizard to complete the deployment.
   - Once complete, you should see the WordPress installation page.

### Amazon RDS Setup
1. **Create RDS MySQL Database**:  
   - Navigate to the **RDS Console** and create a MySQL instance.
   - Select **multi-AZ** deployment for high availability.
   - Use the **db.t3.micro** instance type and enable automatic backups.

2. **Connect WordPress to RDS**:  
   - Update the `wp-config.php` file in your WordPress deployment with the RDS endpoint and credentials.

---

## Step 2: Automate with Terraform

### Setup Instructions
1. Create a new directory for the project and initialize Terraform.

   ```bash
   mkdir aws-wordpress-terraform
   cd aws-wordpress-terraform
   terraform init
   ```

2. **Download the Terraform Configuration**:
   - The Terraform configuration file `main.tf` is available in the GitHub repository.

3. **Run Terraform**:
   ```bash
   terraform apply
   ```
   This command will automatically provision the entire infrastructure on AWS, including Elastic Beanstalk, RDS, IAM roles, and associated configurations.

---

## Security Best Practices
1. **Use AWS KMS** for encryption of sensitive data, including RDS credentials.
2. **Enable MFA** for secure access to AWS accounts.
3. **Implement SSL** connections for data-in-transit between WordPress and RDS.
4. Apply the **Least Privilege Principle** to IAM roles.
5. Utilize **CloudWatch** and **CloudTrail** for monitoring and logging.

---

## Cleanup
To avoid incurring charges, ensure that all AWS resources are deleted after testing. For manual cleanup, delete the Elastic Beanstalk environment, terminate the RDS instance, and remove any S3 buckets.

For Terraform cleanup, simply run:

```bash
terraform destroy
```

---

## Conclusion
This guide outlines the process of deploying a **secure and scalable WordPress website** on AWS, leveraging both manual setup and Terraform automation. By adhering to AWS best practices, this project showcases expertise in cloud architecture, security, and automation, making it an excellent resource for developers and cloud professionals.

---

## Acknowledgments
Thanks to the [AWS Documentation](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/php-hawordpress-tutorial.html) for providing invaluable insights and inspiration for this tutorial.
