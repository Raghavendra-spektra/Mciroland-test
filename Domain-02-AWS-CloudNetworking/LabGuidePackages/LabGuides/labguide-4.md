# **Scenario 4: Create S3 Bucket with Versioning**

## **Lab Overview**

Create an Amazon S3 bucket with versioning enabled for data protection and recovery capabilities.

## **Implementation Steps**

### Step 1: Create S3 Bucket

```bash
aws s3api create-bucket \
  --bucket production-data-bucket-$(date +%s) \
  --region us-east-1
```

### Step 2: Enable Versioning

```bash
aws s3api put-bucket-versioning \
  --bucket production-data-bucket \
  --versioning-configuration Status=Enabled
```

### Step 3: Configure Bucket Policy

```bash
aws s3api put-bucket-policy --bucket production-data-bucket --policy file://policy.json
```

### Step 4: Upload Objects

```bash
aws s3 cp file.txt s3://production-data-bucket/
aws s3 ls s3://production-data-bucket/ --recursive --human-readable
```

## **Validation Check**

<validation step="aws-s3-001" />

You have successfully completed Scenario 4.
