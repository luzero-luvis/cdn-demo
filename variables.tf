variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
  default     = "cdn-demo"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "demo"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class (PriceClass_All | PriceClass_200 | PriceClass_100)"
  type        = string
  default     = "PriceClass_100"
}

variable "default_ttl" {
  description = "Default cache TTL in seconds"
  type        = number
  default     = 86400
}

variable "max_ttl" {
  description = "Maximum cache TTL in seconds"
  type        = number
  default     = 31536000
}
