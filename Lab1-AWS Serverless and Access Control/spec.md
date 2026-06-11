# Lab Specification: AWS Serverless and Access Control

## Overview
| Attribute | Value |
|---|---|
| Lab Name | AWS Serverless Integration Lab |
| Lab Type | AWS |
| Last Updated | 2026-06-11 |

## Package Contents Summary

| Component | Files | Details |
|---|---:|---|
| **DeploymentPackage** | 2 | Templates: 2, Scripts: 0, Bicep: 0 |
| **LabGuidePackage** | 5 | Guides: 4, Questions: 0, Media: 0 |
| **Images** | 6 | Media: 6 |
| **ValidationPackage** | 4 | Validation Scripts: 4 |
| **Permissions** | 0 | RBAC: 0, Policies: 0 |

## Deployment Components

### Infrastructure as Code
- **Templates**: 2 CloudLabs deployment template/parameter JSON files
- **Scripts**: 0 deployment/setup scripts
- **Deployment Method**: CloudLabs provisioning for AWS lab resources

### Lab Content
- **Lab Guides**: 4 guide documents covering getting started plus three AWS serverless and access control scenarios
- **Assessment Questions**: 0 question files
- **Media Assets**: 6 image files stored in the Images package

### Validations & Testing
- **Validation Scripts**: 4 automated PowerShell validation scripts
- **Assessment Approach**: Automated validation of Lambda, IAM, S3, and CloudWatch tasks

### Access Control
- **RBAC Configurations**: 0 role-based access control files
- **Policy Definitions**: 0 policy files

## Use Case Summary
This lab assesses AWS serverless integration and access control skills. Learners create an HTTP-triggered Lambda function, configure a function URL, create an IAM role for EC2 to access S3 securely, attach the role to an EC2 instance, add an S3 trigger to Lambda, and validate events using CloudWatch Logs.

## What This Package Includes
- Infrastructure deployment templates and parameters
- Lab guide markdown files and master document metadata
- Media assets referenced by the lab guide
- Automated validation scripts for AWS serverless and access control tasks

## What This Package Does NOT Include
- Runtime environment/live infrastructure
- Sensitive credentials or secrets
- Live execution results or logs
- Third-party dependencies beyond provision-time installation
- RBAC or policy configuration files
- Candidate personal data or assessment responses

## Lab Delivery Model
- **Provisioning**: Cloud-based AWS lab infrastructure
- **Access**: Secure AWS console and provisioned lab resource access through CloudLabs
- **Validation**: Automated step-by-step validation with immediate feedback
- **Assessment**: Hands-on Lambda, IAM, S3, EC2 role attachment, and CloudWatch validation tasks

## Maintenance Notes
- Infrastructure is ephemeral and destroyed after lab completion
- Validation scripts assume specific Lambda, IAM, EC2, S3, and CloudWatch resource naming conventions
- Deployment templates, validation scripts, and guide steps should remain aligned when resource names or scenarios change

---
Generated on 2026-06-11 | CloudLabs by Spektra Systems
