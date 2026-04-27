output "cloudfront_domain_name" {
  description = "CloudFront distribution domain — use this URL to access content"
  value       = "https://${aws_cloudfront_distribution.this.domain_name}"
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (use for cache invalidations)"
  value       = aws_cloudfront_distribution.this.id
}

output "s3_bucket_name" {
  description = "Name of the S3 origin bucket"
  value       = aws_s3_bucket.content.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 origin bucket"
  value       = aws_s3_bucket.content.arn
}
