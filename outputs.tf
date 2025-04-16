output "cluster_issuer_name" {
  description = "The name of the ClusterIssuer"
  value       = var.create_clusterIssuer ? var.clusterIssuer_name : null
}