# cdn-demo

Static site delivery via **AWS CloudFront + S3**, provisioned with Terraform.

## Architecture

```
Browser → CloudFront Edge → S3 Bucket (private, OAC-only access)
```

- S3 bucket has **all public access blocked** — objects are never reachable directly
- **Origin Access Control (OAC)** signs every CloudFront→S3 request with SigV4 (modern successor to OAI)
- CloudFront enforces **HTTPS** (HTTP redirects to HTTPS)
- Edge caches content with a 1-day default TTL, up to 1 year max

## Files

```
.
├── provider.tf                  # AWS provider + Terraform version constraints
├── variables.tf                 # Input variables
├── main.tf                      # S3, OAC, CloudFront distribution, bucket policy, file uploads
├── outputs.tf                   # CloudFront URL, distribution ID, bucket name
├── terraform.tfvars.example     # Copy → terraform.tfvars and fill in your values
└── website/
    ├── index.html               # Demo page uploaded to S3
    └── error.html               # 404 page
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- AWS credentials configured (`aws configure` or environment variables)

## Deploy

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

After `apply` completes, Terraform prints the CloudFront URL:

```
cloudfront_domain_name = "https://d1234abcd.cloudfront.net"
```

> **Note:** CloudFront distributions take 5–15 minutes to fully propagate globally on first deploy.

## Invalidate cache

```bash
aws cloudfront create-invalidation \
  --distribution-id $(terraform output -raw cloudfront_distribution_id) \
  --paths "/*"
```

## Tear down

```bash
terraform destroy
```

## Key concepts (from the article)

| Concept | This demo |
|---|---|
| S3 as origin | `aws_s3_bucket.content` |
| Restrict bucket access | `aws_s3_bucket_public_access_block` + OAC bucket policy |
| OAI (legacy) | Replaced by OAC (`aws_cloudfront_origin_access_control`) |
| HTTPS enforcement | `viewer_protocol_policy = "redirect-to-https"` |
| TTL / caching | `default_ttl`, `max_ttl` variables |
| Signed URLs | Not included — add `aws_cloudfront_public_key` + trusted signers to extend |
