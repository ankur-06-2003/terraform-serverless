# Terraform Infrastructure for Serverless Application

This folder contains Terraform code to provision the AWS infrastructure for a **serverless full-stack project** consisting of:

* **Frontend** → React (deployed to S3 + CloudFront)
* **Backend** → Node.js/Express (packaged as AWS Lambda functions)
* **Database** → DynamoDB tables for registration and feedback
* **Workflow** → Step Functions orchestrating backend logic
* **Security** → IAM roles & policies

---

## 📂 **File Structure**

```
terraform/
│
├── provider.tf          # AWS provider configuration
├── variables.tf         # Input variables (tags, region, app name, etc.)
├── outputs.tf           # Key outputs (S3 URL, CloudFront domain, Step Function ARN, etc.)
│
├── s3.tf                # S3 bucket for hosting React frontend
├── cloudfront.tf        # CloudFront distribution for frontend
│
├── lambda.tf            # Lambda functions for backend APIs
├── dynamodb.tf          # DynamoDB tables (registration, feedback)
├── step_function.tf     # Step Function workflow definition
├── iam.tf               # IAM roles and policies for Lambda & Step Functions
│
└── locals.tf            # Local variables (tags, app name, naming convention)
```

---

## ⚙️ **Prerequisites**

* [Terraform >= 1.3](https://developer.hashicorp.com/terraform/downloads)
* [AWS CLI](https://aws.amazon.com/cli/) configured with proper credentials
* Node.js backend packaged for Lambda (using `index.js`, `routes/`, and `models/`)
* React frontend build (`npm run build`) ready to upload to S3

---

## 🚀 **Deployment Steps**

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Validate the configuration

```bash
terraform validate
```

### 3. Plan the infrastructure

```bash
terraform plan -var="app_name=college-fest" -var="tags={Project=\"CollegeFest\", Environment=\"dev\"}"
```

### 4. Apply changes

```bash
terraform apply -auto-approve
```

---

## 📦 **Key Resources Created**

* **S3 Bucket** → Stores React frontend build files
* **CloudFront Distribution** → Serves frontend over HTTPS
* **Lambda Functions** → Backend Express API logic
* **DynamoDB Tables** → Stores registration and feedback data
* **Step Functions** → Orchestrates Lambda workflows
* **IAM Roles** → Permissions for Lambda & Step Functions

---

## 🔑 **Outputs**

After applying, Terraform will print values such as:

* **Frontend URL** → CloudFront distribution domain
* **Step Function ARN** → For triggering workflows
* **DynamoDB Table Names** → Registration & Feedback

---

## 🧹 **Cleanup**

To destroy all created resources:

```bash
terraform destroy -auto-approve
```

---

## 📖 **Notes**

* Update `variables.tf` to customize `app_name`, `region`, and `tags`.
* Ensure `lambda.tf` points to your packaged backend zip file.
* React build files must be synced manually or via CI/CD to the S3 bucket after Terraform creates it.
