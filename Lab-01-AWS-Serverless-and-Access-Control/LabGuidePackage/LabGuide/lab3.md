# Scenario-3 AWS Lambda S3 Trigger and Event-Driven Architecture

## Lab Overview

In this lab, you will configure an Amazon S3 event trigger on an existing AWS Lambda function so it automatically processes and logs a notification to CloudWatch Logs on every file upload. You will add the S3 trigger through the Lambda console, upload a test file, and validate the log output in CloudWatch.

Event-driven serverless architectures are a modern design pattern used by cloud teams to automatically respond to storage events — such as file uploads — without polling or manual intervention, reducing latency and operational overhead.

## Scenario

You have recently joined a cloud operations team as an AWS Solutions Engineer.

The organization is extending its serverless infrastructure by wiring storage events to Lambda functions for automated processing. Your manager has asked you to configure an S3 event trigger on the existing **ServerlessWebApp** Lambda function so that every file uploaded to the designated S3 bucket automatically invokes the function and logs a notification to CloudWatch Logs.

You have been provided access to an AWS environment with a pre-provisioned S3 bucket and must configure the trigger, upload a test file, and verify the log output in CloudWatch.

## Solution

To address this requirement, you will open the existing **ServerlessWebApp** Lambda function from Scenario 1, add an S3 PUT event trigger pointing to the pre-provisioned bucket, and then upload a file to confirm end-to-end invocation. You will validate the result by inspecting the CloudWatch log group for a new log stream containing the bucket name and uploaded file key.

The solution demonstrates core event-driven serverless concepts including S3 event source configuration, automatic Lambda invocation on object upload, and CloudWatch Logs validation — without any code changes.

## Learning Objectives

After completing this lab, you will be able to:

* Configure an S3 event trigger on an existing AWS Lambda function.
* Select the correct S3 event type (PUT) for object upload notifications.
* Upload a file to S3 to invoke a Lambda function automatically.
* Navigate CloudWatch Log groups and log streams to validate function execution.
* Apply AWS event-driven best practices for serverless architectures.

## Environment Information

This lab uses the AWS Management Console. No additional tools or SSH access are required.

All resources must be created in the AWS region provided in your lab environment.

> Note: Use the exact resource names specified in each task. Validation will check for these names.

---

## Assessment Objectives

### Scenario 3: Create Lambda Function Triggered by S3 Upload

This scenario evaluates your ability to configure an S3 event trigger on the **ServerlessWebApp** Lambda function created in Scenario 1 and validate it logs notifications to CloudWatch Logs.

### Task 1: Add the S3 Trigger to the Existing Lambda Function

### Assessment Objectives
1. Open the **ServerlessWebApp** Lambda function, add an S3 PUT trigger on the pre-provisioned bucket **lab-bucket**, and verify the trigger is active.

### Task 2: Validate the S3 Trigger via CloudWatch Logs

### Assessment Objectives
1. Upload a file to **lab-bucket**, then confirm a new log stream is created in the **/aws/lambda/ServerlessWebApp** CloudWatch log group containing the bucket name and uploaded file key.

---

# Detailed Instructions

## Scenario 3: Create Lambda Function Triggered by S3 Upload

### Task 1: Add the S3 Trigger to the Existing Lambda Function

> **Note:** Your S3 bucket is pre-provisioned. Do not create a new Lambda function — use the **ServerlessWebApp** function from Scenario 1.

| Field | Value |
|---|---|
| Lambda function | `ServerlessWebApp` |
| Trigger source | S3 |
| Bucket | `lab-bucket` |
| Event type | `PUT` |

**Success Criteria:**

> - S3 trigger is added to the **ServerlessWebApp** function
> - Trigger source is set to bucket **lab-bucket**
> - Event type is configured as **PUT**

### Task 2: Validate the S3 Trigger via CloudWatch Logs

> **Note:** Do not modify the existing function code — the trigger will log events automatically.

| Field | Value |
|---|---|
| S3 bucket | `lab-bucket` |
| CloudWatch log group | `/aws/lambda/ServerlessWebApp` |

**Success Criteria:**

> - A file is uploaded to **lab-bucket**
> - CloudWatch log group **/aws/lambda/ServerlessWebApp** exists
> - A new log stream is created after the upload

<validation step="ee6836bb-0fdd-48cc-aeb0-2893cda914e1" />

---

## Evaluation Criteria

Your submission will be evaluated based on:

* Correct configuration of the S3 PUT trigger on the ServerlessWebApp function
* Accurate selection of the pre-provisioned bucket as the trigger source
* Successful file upload to the S3 bucket to invoke the function
* Presence of the CloudWatch log group and a new log stream after upload
* Successful validation completion

---

## Completion Criteria

You have successfully completed the assessment when:

* An S3 PUT trigger is configured on the **ServerlessWebApp** Lambda function.
* The trigger source points to the **lab-bucket** S3 bucket.
* A file has been uploaded to **lab-bucket** to invoke the function.
* The CloudWatch log group **/aws/lambda/ServerlessWebApp** contains a new log stream.
* The log entry includes the bucket name and the uploaded file key.
* The validation step completes successfully.

You have successfully completed Scenario 3.