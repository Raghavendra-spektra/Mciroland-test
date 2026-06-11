# **Scenario-2 AWS IAM Role and Access Control**

## **Lab Overview**

In this lab, you will use AWS Identity and Access Management (IAM) to create and assign a role that grants an EC2 instance secure, credential-free access to Amazon S3. You will create an IAM role with the appropriate trust policy, attach a managed S3 read-only policy, and associate the role with a pre-provisioned EC2 instance.

Secure, role-based access to AWS services is a foundational best practice used by cloud operations teams to eliminate the use of long-term access keys and enforce least-privilege access control.

## **Scenario**

You have recently joined a cloud operations team as an AWS Solutions Engineer.

The organization is modernizing its security posture by replacing static access keys with IAM roles for service-to-service communication. Your manager has asked you to create an IAM role that allows an EC2 instance to securely read objects from Amazon S3 — without using any access keys or secrets.

You have been provided access to an AWS environment and must create the IAM role with the correct trusted entity and permissions policy, then attach the role to the designated EC2 instance.

## **Solution**

To address this requirement, you will create an IAM role named **lam-lab-role** with EC2 as the trusted entity and the **AmazonS3ReadOnlyAccess** managed policy attached. You will then associate this role with the pre-provisioned EC2 instance **labvm** using an instance profile. This enables the instance to securely obtain temporary credentials via the instance metadata service.

The solution demonstrates core IAM concepts including role creation, trust policy configuration, managed policy attachment, and instance profile association — without any static credentials.

## **Learning Objectives**

After completing this lab, you will be able to:

* Create and configure an AWS IAM role with a specified trusted entity.
* Attach an AWS managed policy to an IAM role.
* Associate an IAM role with an EC2 instance using an instance profile.
* Validate role attachment through the EC2 console Security tab.
* Apply AWS IAM best practices for credential-free service access.

## **Environment Information**

This lab uses the AWS Management Console. No additional tools or SSH access are required.

All resources must be created in the AWS region provided in your lab environment.

> Note: Use the exact resource names specified in each task. Validation will check for these names.

---

## **Assessment Objectives**

### **Scenario 2: Create IAM Role for EC2 to Access S3 Securely**

This scenario evaluates your ability to create and assign an IAM role that grants an EC2 instance secure access to S3 — without using access keys.

You are expected to follow AWS IAM best practices and use the specified resource names to ensure successful validation.

### **Task 1: Create the IAM Role**

### **Assessment Objectives**
1. Create an IAM role named **lam-lab-role**, configure it with EC2 as the trusted entity, attach the **AmazonS3ReadOnlyAccess** managed policy, and verify successful creation.

### **Task 2: Attach the IAM Role to the EC2 Instance**

### **Assessment Objectives**
1. Locate the pre-provisioned EC2 instance **labvm**, attach the IAM role **lam-lab-role**, and verify the instance profile is visible under the instance's Security tab.

---

# **Detailed Instructions**

## **Scenario 2: Create IAM Role for EC2 to Access S3 Securely**

### Task 1: Create the IAM Role

> **Note:** Use the name exactly as specified above to ensure successful validation.

1. Create a new IAM role named **lam-lab-role**.
2. Attach the following managed policy to the role:

   | Policy | Purpose |
   |---|---|
   | `AmazonS3ReadOnlyAccess` | Grants EC2 read access to S3 |

**Success Criteria:**

> - IAM role **lam-lab-role** is created
> - Trusted entity is set to **EC2**
> - **AmazonS3ReadOnlyAccess** policy is attached

<validation step="e2aa55a5-9126-4e42-b58a-c7bdba7e716c" />

### **Task 2: Attach the IAM Role to the EC2 Instance**

> **Note:** Your EC2 instance is pre-provisioned. Do not modify any other instance settings.

---

## **Evaluation Criteria**

Your submission will be evaluated based on:

* Correct creation of the IAM role with the specified name and trusted entity
* Accurate attachment of the AmazonS3ReadOnlyAccess managed policy
* Proper association of the IAM role with the EC2 instance
* Correct instance profile visibility under the Security tab
* Successful validation completion

---

## **Completion Criteria**

You have successfully completed the assessment when:

* An IAM role named **lam-lab-role** exists with EC2 as the trusted entity.
* The **AmazonS3ReadOnlyAccess** managed policy is attached to the role.
* The role is attached to the EC2 instance **labvm**.
* The instance profile is visible under the instance's **Security** tab.
* Both validation steps complete successfully.

## **You have successfully completed Scenario 2.**