# Lab Specification: Linux Administration

## Overview
| Attribute | Value |
|---|---|
| Lab Name | Lab - 04 Linux Administration |
| Lab Type | Linux |
| Last Updated | 2026-06-11 |

## Package Contents Summary

| Component | Files | Details |
|---|---:|---|
| **DeploymentPackage** | 2 | Templates: 2, Scripts: 0, Bicep: 0 |
| **LabGuidePackage** | 13 | Guides: 6, Questions: 0, Media: 6 |
| **ValidationsPackage** | 8 | Validation Scripts: 8 |
| **Permissions** | 0 | RBAC: 0, Policies: 0 |

## Deployment Components

### Infrastructure as Code
- **Templates**: 2 ARM template/parameter JSON files
- **Scripts**: 0 deployment/setup scripts
- **Deployment Method**: CloudLabs provisioning via ARM templates

### Lab Content
- **Lab Guides**: 6 guide documents covering getting started plus five Linux administration scenarios
- **Assessment Questions**: 0 question files
- **Media Assets**: 6 media files used by the lab guide

### Validations & Testing
- **Validation Scripts**: 8 automated PowerShell validation scripts
- **Assessment Approach**: Automated task validation mapped to Linux administration activities

### Access Control
- **RBAC Configurations**: 0 role-based access control files
- **Policy Definitions**: 0 policy files

## Use Case Summary
This lab assesses practical Linux administration skills. Learners manage users and groups, configure directory permissions, install and remove packages, monitor and control processes, and configure static IP networking with documentation.

## What This Package Includes
- Infrastructure deployment templates and parameters
- Lab guide markdown files and master document metadata
- Media assets referenced by the lab guide
- Automated validation scripts for administration tasks

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
- **Assessment**: Hands-on Linux administration scenarios and system configuration tasks

## Maintenance Notes
- Infrastructure is ephemeral and destroyed after lab completion
- Validation scripts assume specific user, group, package, process, and network configuration states
- Lab guide steps and validation scripts should remain synchronized to avoid false validation failures

---
Generated on 2026-06-11 | CloudLabs by Spektra Systems
