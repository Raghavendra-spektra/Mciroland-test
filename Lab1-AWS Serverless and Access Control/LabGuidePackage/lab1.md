# **Scenario-1 AWS Serverless and Access Control**

## **Lab Overview**

In this lab, you will use AWS Lambda to build and deploy a serverless web application that serves HTML content directly through a Function URL — without using API Gateway. You will create and configure a Lambda function, deploy Python-based web handler code, and validate HTTP routing behaviour across multiple URL paths.

Serverless web hosting is a modern deployment pattern used by development and operations teams to reduce infrastructure overhead, lower costs, and improve scalability for lightweight web applications.

 ## **Scenario**

You have recently joined a cloud operations team as an AWS Solutions Engineer.

The organization is modernizing its web application infrastructure by migrating lightweight web apps to a fully serverless model. Your manager has asked you to build and deploy a serverless web application using AWS Lambda with a publicly accessible Function URL — no API Gateway required.

You have been provided access to an AWS environment and must create a Lambda function that serves HTML content based on the incoming request path, configure a public Function URL, and validate the HTTP responses in a browser.

## **Solution**

To address this requirement, you will create a Lambda function using the Python 3.12 runtime, deploy a custom web handler that returns HTML responses based on URL path routing, and expose the function through a public Function URL with no authentication. You will then test the application using a browser to verify correct HTTP status codes and page content.

The solution demonstrates core serverless concepts including function creation, code deployment, Function URL configuration, and HTTP path-based routing — without any additional networking infrastructure.

## **Learning Objectives**

After completing this lab, you will be able to:

* Create and configure an AWS Lambda function with a specified runtime.
* Deploy Python-based handler code using the AWS Lambda console.
* Configure a Lambda Function URL with public access.
* Implement URL path routing logic inside a Lambda handler.
* Validate HTTP responses using a browser and developer tools.

## **Environment Information**

This lab uses the AWS Management Console. No additional tools or SSH access are required.

All resources must be created in the AWS region provided in your lab environment.

> Note: Use the exact resource names specified in each task. Validation will check for these names.

---

## **Assessment Objectives**

### **Scenario 1: Create HTTP-triggered Serverless Function**

Build and deploy a Lambda function that serves an HTML web application over HTTP using a Function URL.

### **Task 1: Create and Deploy the Lambda Function**

### **Assessment Objectives**
1. Create a Lambda function named **ServerlessWebApp**, configure it with the Python 3.12 runtime, deploy a custom web handler, and verify successful deployment.

### **Task 2: Configure Function URL and Test**

### **Assessment Objectives**
1. Enable a public Function URL on the Lambda function, set the auth type to **NONE**, and validate the HTTP routing behaviour for multiple URL paths in a browser.

---

# **Detailed Instructions**

## **Scenario 1: Create HTTP-triggered Serverless Function**

### **Task 1: Create and Deploy the Lambda Function**

> **Note:** Follow the specified naming conventions exactly to ensure validation works properly.

| Field | Value |
|---|---|
| Function name | `ServerlessWebApp` |
| Runtime | Python 3.12 |

> **Note:** Use the name exactly as specified above to ensure successful validation.

```python
import json

def lambda_handler(event, context):
    print(json.dumps(event))
    path = event.get("rawPath") or event.get("path") or "/"

    if path == "/" or path == "/index.html":
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "text/html"},
            "body": get_index(),
            "isBase64Encoded": False
        }
    else:
        return {
            "statusCode": 404,
            "headers": {"Content-Type": "text/html"},
            "body": get_error(),
            "isBase64Encoded": False
        }

def get_index():
    return """<!DOCTYPE html>
<html>
<head>
    <title>Lambda Web App</title>
</head>
<body>
    <h1>Welcome to Serverless Web App</h1>
    <p>This page is served from AWS Lambda Function URL.</p>
</body>
</html>"""

def get_error():
    return """<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h1>404 - Page Not Found</h1>
    <p>The page you requested does not exist.</p>
</body>
</html>"""
```


**Success Criteria:**

> - Lambda function **ServerlessWebApp** is created
> - Runtime is set to **Python 3.12**
> - Code is successfully deployed

<validation step="8e733187-46df-4139-b57f-5ddeb4948a8a" />

### **Task 2: Configure Function URL and Test**

> **Note:** Use Auth type **NONE** to allow public HTTP access to your function.


**Success Criteria:**

> - Function URL is enabled on **ServerlessWebApp**
> - Auth type is set to **NONE**
> - Browser returns the welcome page on `/` and `/index.html`
> - Browser returns a 404 page on an unknown path

<validation step="29e38797-ef36-4be6-8a35-731e1f3d07f9" />

---

## **Evaluation Criteria**

Your submission will be evaluated based on:

* Correct creation of the Lambda function with the specified name and runtime
* Accurate deployment of the Python handler code
* Proper configuration of the Function URL with Auth type NONE
* Correct HTTP routing behaviour for defined and undefined paths
* Successful validation completion

---

## **Completion Criteria**

You have successfully completed the assessment when:

* A Lambda function named **ServerlessWebApp** exists with the Python 3.12 runtime.
* The function code is deployed and active.
* A Function URL is enabled with Auth type set to **NONE**.
* The browser returns a 200 welcome page on `/` and `/index.html`.
* The browser returns a 404 page on any unknown path.
* Both validation steps complete successfully.

## **You have successfully completed Scenario 1.**