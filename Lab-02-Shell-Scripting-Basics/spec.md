# Lab Specification: Shell Scripting Basics

## Overview
| Attribute | Value |
|---|---|
| Lab Name | Shell Scripting and Linux Automation Lab |
| Lab Type | Linux |
| Last Updated | 2026-06-11 |

## Package Contents Summary

| Component | Files | Details |
|---|---:|---|
| **DeploymentPackage** | 2 | Templates: 2, Scripts: 0, Bicep: 0 |
| **LabGuidePackage** | 16 | Guides: 6, Questions: 0, Media: 9 |
| **ValidationsPackage** | 5 | Validation Scripts: 5 |
| **Permissions** | 0 | RBAC: 0, Policies: 0 |

## Deployment Components

### Infrastructure as Code
- **Templates**: 2 ARM template/parameter JSON files
- **Scripts**: 0 deployment/setup scripts
- **Deployment Method**: CloudLabs provisioning via ARM templates

### Lab Content
- **Lab Guides**: 6 guide documents covering getting started plus five shell scripting scenarios
- **Assessment Questions**: 0 question files
- **Media Assets**: 9 media files used by the lab guide

### Validations & Testing
- **Validation Scripts**: 5 automated PowerShell validation scripts
- **Assessment Approach**: Automated task validation aligned to each shell scripting scenario

### Access Control
- **RBAC Configurations**: 0 role-based access control files
- **Policy Definitions**: 0 policy files

## Use Case Summary
This lab assesses foundational shell scripting and Linux automation skills. Learners create scripts for environment reporting, employee user provisioning, disk utilization monitoring, automated backups, and reusable system administration tooling.

## What This Package Includes
- Infrastructure deployment templates and parameters
- Lab guide markdown files and master document metadata
- Media assets referenced by the lab guide
- Automated validation scripts for hands-on tasks

## What This Package Does NOT Include
- Runtime environment/live infrastructure
- Sensitive credentials or secrets
- Live execution results or logs
- Third-party dependencies beyond provision-time installation
- RBAC or policy configuration files
- Candidate personal data or assessment responses

## Lab Delivery Model
- **Provisioning**: Cloud-based Linux virtual machine environment
- **Access**: Secure remote access to the lab VM through the CloudLabs interface
- **Validation**: Automated step-by-step validation with immediate feedback
- **Assessment**: Hands-on shell scripting tasks and scenario-based problem solving

## Maintenance Notes
- Infrastructure is ephemeral and destroyed after lab completion
- Validation scripts assume the expected Linux paths, users, files, and naming conventions from the lab guide
- Deployment templates and guide metadata should be kept in sync when scenario names or validation tasks change

---
Generated on 2026-06-11 | CloudLabs by Spektra Systems
