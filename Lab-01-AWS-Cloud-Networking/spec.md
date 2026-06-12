# Lab Specification: AWS Cloud Networking

## Overview
| Attribute | Value |
|---|---|
| Lab Name | AWS Cloud Networking |
| Lab Type | AWS |
| Last Updated | 2026-06-11 |

## Package Contents Summary

| Component | Files | Details |
|---|---:|---|
| **DeploymentPackage** | 2 | Templates: 2, Scripts: 0, Bicep: 0 |
| **LabGuidePackage** | 8 | Guides: 4, Questions: 0, Media: 3 |
| **ValidationPackage** | 7 | Validation Scripts: 7 |
| **Permissions** | 1 | RBAC: 0, Policies: 1 |

## Deployment Components

### Infrastructure as Code
- **Templates**: 2 CloudLabs deployment template/parameter JSON files
- **Scripts**: 0 deployment/setup scripts
- **Deployment Method**: CloudLabs provisioning for AWS lab resources

### Lab Content
- **Lab Guides**: 4 guide documents covering getting started plus three AWS networking scenarios
- **Assessment Questions**: 0 question files
- **Media Assets**: 3 media files used by the lab guide

### Validations & Testing
- **Validation Scripts**: 7 automated PowerShell validation scripts
- **Assessment Approach**: Automated validation of AWS networking, compute, load balancing, scaling, and database tasks

### Access Control
- **RBAC Configurations**: 0 role-based access control files
- **Policy Definitions**: 1 AWS policy file

## Use Case Summary
This lab assesses AWS cloud networking and application infrastructure skills. Learners create a custom VPC, configure public and private subnets, set up NAT and routing, launch EC2, deploy an Application Load Balancer, configure Auto Scaling, and deploy a MySQL RDS instance.

## What This Package Includes
- Infrastructure deployment templates and parameters
- Lab guide markdown files and master document metadata
- Media assets referenced by the lab guide
- Automated validation scripts for AWS hands-on tasks
- AWS policy configuration for lab access control

## What This Package Does NOT Include
- Runtime environment/live infrastructure
- Sensitive credentials or secrets
- Live execution results or logs
- Third-party dependencies beyond provision-time installation
- Candidate personal data or assessment responses

## Lab Delivery Model
- **Provisioning**: Cloud-based AWS lab infrastructure
- **Access**: Secure AWS console and provisioned lab resource access through CloudLabs
- **Validation**: Automated step-by-step validation with immediate feedback
- **Assessment**: Hands-on AWS networking, compute, scaling, and database deployment tasks

## Maintenance Notes
- Infrastructure is ephemeral and destroyed after lab completion
- Validation scripts assume specific AWS resource names, regions, tags, and networking configuration
- Policy, guide, template, and validation updates should be reviewed together when AWS resource scope changes

---
Generated on 2026-06-11 | CloudLabs by Spektra Systems
