output "cluster_endpoint" {
  value = try(aws_rds_cluster.aurora[0].endpoint, null)
}

output "reader_endpoint" {
  value = try(aws_rds_cluster.aurora[0].reader_endpoint, null)
}

output "writer_endpoint" {
  value = try(aws_rds_cluster_instance.aurora_writer[0].endpoint, null)
}

output "reader_instances" {
  value = [for r in aws_rds_cluster_instance.aurora_readers : r.endpoint]
}

output "cluster_arn" {
  value = try(aws_rds_cluster.aurora[0].arn, null)
}
