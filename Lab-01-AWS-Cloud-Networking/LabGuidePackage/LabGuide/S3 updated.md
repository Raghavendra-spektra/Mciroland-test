# AWS Auto Scaling and Load Balancing Assessment

## Lab Overview

In this assessment, you will deploy and configure a highly available web application architecture using AWS Elastic Load Balancing and Amazon EC2 Auto Scaling. You will create an Application Load Balancer, configure a Target Group, deploy an Auto Scaling Group, and implement automatic scaling based on workload demand.

## Scenario

You have joined an organization as a Cloud Engineer. The company requires a scalable and fault-tolerant web application environment capable of handling varying traffic loads. Your task is to deploy and configure load balancing and automated scaling services to ensure application availability, reliability, and performance.

## Solution

To meet these requirements, you will create an Application Load Balancer to distribute incoming traffic, configure a Target Group for backend instances, deploy an Auto Scaling Group using a Launch Template, and implement dynamic scaling policies. This architecture ensures high availability, automatic capacity management, and efficient traffic distribution across application instances.
# Assessment Objectives

This lab environment is designed to evaluate your practical skills in deploying scalable and highly available web applications on AWS. As part of this assessment, you will configure load balancing, automated instance provisioning, and dynamic scaling using Amazon EC2 Auto Scaling and an Application Load Balancer.

You are expected to follow AWS best practices and use the specified resource names to ensure successful validation.
> **Note:** To ensure successful validation and consistency across all assessment tasks, you must deploy all AWS resources in **one of the following supported AWS Regions only**:
>
> - us-east-2 
> - us-east-1
> - us-west-2
>
> Resources deployed in any other AWS Region may not be detected by the validation scripts and could result in assessment failures.

---

## Task 1: Deploy an Application Load Balancer

> **Note:** Follow the specified naming conventions exactly to ensure validation works properly.

1. Create an Application Load Balancer named **Lab1-ALB**.
2. Deploy the load balancer in the public subnets created in Scenario 1.
3. Configure an HTTP listener on port **80**.

---
### Success Criteria

- An Application Load Balancer named **Lab1-ALB** exists.
- An HTTP listener is configured on port **80**.

---
<validation step="db4abf79-5f64-40c0-a0f2-bbd26ca6c6b7" />


## Task 2: Create and Configure a Target Group

> **Note:** Follow the specified naming conventions exactly to ensure validation works properly.

1. Create a Target Group named **Lab1-TG**.
2. Configure the target group for HTTP traffic.
3. Associate **Lab1-TG** with the listener configured on **Lab1-ALB**.

---

## Task 3: Configure an Auto Scaling Group

> **Note:** Follow the specified naming conventions exactly to ensure validation works properly.

1. Create an Auto Scaling Group named **Lab1-ASG** using **Lab1-Web-LT**.
2. Deploy Auto Scaling instances into the private subnets created in Scenario 1.
3. Register all instances with **Lab1-TG**.

---
### Success Criteria

- An Auto Scaling Group named **Lab1-ASG** exists.
- Instances are deployed in private subnets.
- Instances are registered with **Lab1-TG**.

---
<validation step="b8f83458-78bf-4c07-af9e-6dc5f25baf90" />


## Task 4: Configure Automatic Scaling and Validate Load Balancing

1. Configure **Lab1-ASG** with:
   - Minimum Capacity: **2**
   - Desired Capacity: **2**
   - Maximum Capacity: **4**

2. Create a scaling policy that triggers when average CPU utilization reaches **60% or higher**.

3. Verify that the DNS name of **Lab1-ALB** successfully returns a web page from the Apache web servers running in the Auto Scaling Group.

---


## You have successfully completed the Assessment.