resource "aws_grafana_workspace" "main" {
  name                 = "${local.project}-grafana"
  account_access_type  = var.grafana_account_access_type
  authentication_providers = var.grafana_auth_providers
  permission_type      = "SERVICE_MANAGED"

  data_sources = [
    "AMAZON_OPENSEARCH_SERVICE",
    "ATHENA"
  ]

  tags = merge(local.tags, {
    "Name" = "${local.project}-grafana"
  })
}
