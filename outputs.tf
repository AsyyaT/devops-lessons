output "s3_bucket_name" {
  description = "S3 bucket name for states"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for states"
  value       = module.s3_backend.dynamodb_table_name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}


output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.ecr_url
}

output "jenkins_release" {
  description = "Jenkins release name"
  value       = module.jenkins.jenkins_release_name
}

output "jenkins_namespace" {
  description = "Jenkins namespace"
  value       = module.jenkins.jenkins_namespace
}


output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = module.argo_cd.namespace
}

output "argocd_server_service" {
  description = "ArgoCD server service"
  value       = module.argo_cd.argo_cd_server_service
}

output "argocd_admin_password" {
  description = "Initial admin password"
  value       = module.argo_cd.admin_password
}

output "aurora_cluster_endpoint" {
  value = module.rds.cluster_endpoint
}

output "aurora_reader_endpoint" {
  value = module.rds.reader_endpoint
}

output "aurora_writer_endpoint" {
  value = module.rds.writer_endpoint
}

output "aurora_readers" {
  value = module.rds.reader_instances
}

output "aurora_cluster_arn" {
  value = module.rds.cluster_arn
}
