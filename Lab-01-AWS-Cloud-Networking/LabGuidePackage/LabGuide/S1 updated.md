# AWS Networking Assessment

## Lab Overview

In this assessment, you will design and configure core AWS networking components to build a secure and scalable Virtual Private Cloud (VPC) environment. You will create public and private networking infrastructure, configure Internet and NAT connectivity, implement routing, and apply network security controls using AWS networking services.

## Scenario

You have joined an organization as a Cloud Network Engineer. The company requires a secure AWS networking foundation to host its applications and services. Your task is to design and configure a custom VPC architecture that supports both Internet-facing and private resources while following AWS networking best practices.

## Solution

To meet these requirements, you will create and configure AWS networking resources including a VPC, public and private subnets, route tables, Internet Gateway, NAT Gateway, Security Groups, and Network ACLs. By implementing proper routing and security controls, you will ensure secure communication between resources while maintaining controlled Internet access for public and private workloads.

# Assessment Objectives

This lab environment is designed to evaluate your practical skills in designing and configuring AWS networking infrastructure. As part of this assessment, you will create a custom Virtual Private Cloud (VPC) architecture with public and private networking components, secure Internet connectivity, and controlled outbound access for private resources.

You are expected to follow AWS networking best practices and use the specified resource names to ensure successful validation.

> **Note:** To ensure successful validation and consistency across all assessment tasks, you must deploy all AWS resources in **one of the following supported AWS Regions only**:
>
> - us-east-2 
> - us-west-2
> - us-east-1
>
> Resources deployed in any other AWS Region may not be detected by the validation scripts and could result in assessment failures.

---

## Task 1: Create a Custom VPC

> **Note:** Follow the specified naming conventions exactly to ensure validation works properly.

1. Create a VPC named **Lab1-VPC**.
2. Configure the VPC with the CIDR block **10.0.0.0/16**.

### Success Criteria

- A VPC named **Lab1-VPC** exists.
- The VPC CIDR block is **10.0.0.0/16**.

<validation step="7c223548-1ec1-41c0-b46b-77d6b1f8ef8d" />

---

## Task 2: Create Public and Private Subnets

> **Note:** Follow the specified naming conventions exactly to ensure validation works properly.

1. Create the following public subnets using **/24** CIDR blocks:
   - **Public-Subnet-A**
   - **Public-Subnet-B**

2. Create the following private subnets using **/24** CIDR blocks:
   - **Private-Subnet-A**
   - **Private-Subnet-B**

3. Ensure the subnets are distributed across a minimum of **2 Availability Zones**.

### Success Criteria

- The following subnets exist:
  - **Public-Subnet-A**
  - **Public-Subnet-B**
  - **Private-Subnet-A**
  - **Private-Subnet-B**
- All subnets use **/24** CIDR blocks.
- Subnets are distributed across at least **2 Availability Zones**.

<validation step="4f566017-9a08-4cf4-99d0-e94b537dc69f" />

---

## Task 3: Configure Internet Gateway and Public Routing

1. Create an Internet Gateway named **Lab1-IGW**.
2. Attach the Internet Gateway to **Lab1-VPC**.
3. Create a route table named **Public-RT**.
4. Associate **Public-RT** with both public subnets.

---

## Task 4: Configure NAT Gateway and Private Routing

1. Create a NAT Gateway named **Lab1-NAT-GW** in one of the public subnets.
2. Create a route table named **Private-RT**.
3. Associate **Private-RT** with both private subnets.

### Success Criteria

- A NAT Gateway named **Lab1-NAT-GW** exists.
- A route table named **Private-RT** exists.

<validation step="f5dfc630-530e-4e00-a23b-5bab3a3b42f9" />

---

## Task 5: Configure Network Security

1. Create and configure the required Security Groups for the VPC resources.
2. Configure Network ACLs for public and private subnet traffic control.
3. Ensure inbound access is restricted to only the required ports and protocols.
4. Do not configure overly permissive inbound rules.

---

## You have successfully completed the Assessment.