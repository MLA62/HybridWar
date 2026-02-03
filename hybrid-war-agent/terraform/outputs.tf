output "vpc_id" {
  description = "ID der bereitgestellten VPC."
  value       = aws_vpc.main.id
}

output "eks_cluster_name" {
  description = "Name des EKS-Clusters."
  value       = aws_eks_cluster.main.name
}

output "s3_bucket" {
  description = "Name des S3-Buckets für Rohdaten."
  value       = aws_s3_bucket.raw_data.bucket
}

output "kinesis_stream_arn" {
  description = "ARN des Kinesis-Datenstroms."
  value       = aws_kinesis_stream.ingest.arn
}

output "opensearch_endpoint" {
  description = "OpenSearch HTTPS Endpoint."
  value       = aws_opensearch_domain.threat_intel.endpoint
}

output "aurora_endpoint" {
  description = "Reader Endpoint des Aurora-Clusters."
  value       = aws_rds_cluster.aurora.reader_endpoint
}

output "neptune_endpoint" {
  description = "Endpoint des Neptune-Clusters."
  value       = aws_neptune_cluster.graph.endpoint
}

output "grafana_workspace_id" {
  description = "ID des AWS Managed Grafana Workspace."
  value       = aws_grafana_workspace.main.id
}

output "alerts_topic_arn" {
  description = "SNS Topic ARN für Alerts."
  value       = aws_sns_topic.alerts.arn
}
