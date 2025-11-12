output "s3_bucket_name" {
  value       = var.bucket_name
  description = "Name of the existing S3 bucket used for Terraform state"
}

output "dynamodb_table_name" {
  value       = var.table_name
  description = "Name of the DynamoDB table used for Terraform state locking"
}