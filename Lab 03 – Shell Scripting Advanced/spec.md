# Lab Specification: Shell Scripting Advanced

## Overview
| Attribute | Value |
|---|---|
| Lab Name | Shell Scripting Advanced Assessment Lab |
| Lab Type | Linux |
| Last Updated | 2026-06-11 |

## Package Contents Summary

| Component | Files | Details |
|---|---:|---|
| **DeploymentPackages** | 2 | Templates: 2, Scripts: 0, Bicep: 0 |
| **LabGuidePackages** | 14 | Guides: 6, Questions: 0, Media: 7 |
| **Validations Package** | 7 | Validation Scripts: 7 |
| **Permissions** | 0 | RBAC: 0, Policies: 0 |

## Deployment Components

### Infrastructure as Code
- **Templates**: 2 ARM template/parameter JSON files
- **Scripts**: 0 deployment/setup scripts
- **Deployment Method**: CloudLabs provisioning via ARM templates

### Lab Content
- **Lab Guides**: 6 guide documents covering getting started plus five advanced shell scripting scenarios
- **Assessment Questions**: 0 question files
- **Media Assets**: 7 media files used by the lab guide

### Validations & Testing
- **Validation Scripts**: 7 automated PowerShell validation scripts
- **Assessment Approach**: Automated validation for scenario tasks, including multi-task scenarios

### Access Control
- **RBAC Configurations**: 0 role-based access control files
- **Policy Definitions**: 0 policy files

## Use Case Summary
This lab assesses advanced shell scripting for Linux operations. Learners parse log files, monitor and restart services, automate script execution with cron, check web server availability, and use exit codes and debugging practices.

## What This Package Includes
- Infrastructure deployment templates and parameters
- Lab guide markdown files and master document metadata
- Media assets referenced by the lab guide
- Automated validation scripts for advanced shell scripting tasks

## What This Package Does NOT Include
- Runtime environment/live infrastructure
- Sensitive credentials or secrets
- Live execution results or logs
- Third-party dependencies beyond provision-time installation
- RBAC or policy configuration files
- Candidate personal data or assessment responses

## Lab Delivery Model
- **Provisioning**: Cloud-based Linux virtual machine environment
- **Access**: SSH or CloudLabs remote access to the lab VM
- **Validation**: Automated step-by-step validation with immediate feedback
- **Assessment**: Scenario-based scripting, automation, troubleshooting, and validation tasks

## Maintenance Notes
- Infrastructure is ephemeral and destroyed after lab completion
- Validation scripts assume specific script names, file paths, services, and cron behavior from the lab guide
- Guide metadata, validation scripts, and deployment parameters should be updated together when scenarios change

---
Generated on 2026-06-11 | CloudLabs by Spektra Systems
