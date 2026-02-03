variable "project_name" {
  description = "Name des Projekts für Tagging und Naming."
  type        = string
  default     = "hybrid-war-agent"
}

variable "aws_region" {
  description = "AWS-Region für die Bereitstellung."
  type        = string
  default     = "eu-central-1"
}

variable "default_tags" {
  description = "Zusätzliche Tags für alle Ressourcen."
  type        = map(string)
  default = {
    Environment = "dev"
    Owner        = "threat-intel"
  }
}

variable "vpc_cidr" {
  description = "CIDR-Block für die VPC."
  type        = string
  default     = "10.40.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR-Blöcke für öffentliche Subnetze."
  type        = list(string)
  default     = ["10.40.1.0/24", "10.40.2.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) > 0
    error_message = "Es muss mindestens ein öffentliches Subnetz definiert sein."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR-Blöcke für private Subnetze."
  type        = list(string)
  default     = ["10.40.11.0/24", "10.40.12.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) > 0
    error_message = "Es muss mindestens ein privates Subnetz definiert sein."
  }
}

variable "availability_zones" {
  description = "Verfügbarkeitszonen für Subnetze und EKS."
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]

  validation {
    condition     = length(var.availability_zones) >= length(var.private_subnet_cidrs)
    error_message = "Die Anzahl der Availability Zones muss mindestens der Anzahl privater Subnetze entsprechen."
  }
}

variable "eks_version" {
  description = "Kubernetes-Version für den EKS-Cluster."
  type        = string
  default     = "1.28"
}

variable "eks_cluster_role_arn" {
  description = "IAM Role ARN für den EKS-Control-Plane-Service."
  type        = string
}

variable "eks_node_role_arn" {
  description = "IAM Role ARN für die EKS-Worker-Nodes."
  type        = string
}

variable "aurora_master_username" {
  description = "Master-Username für das Aurora-Cluster (aus Secrets Manager referenzieren)."
  type        = string
  default     = null
}

variable "aurora_master_password" {
  description = "Master-Passwort für das Aurora-Cluster (aus Secrets Manager referenzieren)."
  type        = string
  sensitive   = true
  default     = null
}

variable "opensearch_version" {
  description = "OpenSearch-Version."
  type        = string
  default     = "2.9"
}

variable "kinesis_shard_count" {
  description = "Shard-Anzahl für den Kinesis-Datenstrom."
  type        = number
  default     = 1

  validation {
    condition     = var.kinesis_shard_count >= 1
    error_message = "Die Shard-Anzahl muss mindestens 1 sein."
  }
}

variable "grafana_account_access_type" {
  description = "Zugriffsmodell für das Grafana-Workspace (CURRENT oder ORGANIZATION)."
  type        = string
  default     = "CURRENT_ACCOUNT"
}

variable "grafana_auth_providers" {
  description = "Aktivierte Authentifizierungsanbieter für Grafana."
  type        = list(string)
  default     = ["SAML", "AWS_SSO"]
}

variable "scoring_state_machine_role_arn" {
  description = "IAM Role ARN für die Step Functions Scoring Engine."
  type        = string
}

variable "alert_emails" {
  description = "Liste von E-Mail-Adressen für SNS-Abonnements."
  type        = list(string)
  default     = []
}

variable "slack_webhook_url" {
  description = "Optionaler Slack Webhook für Alerts."
  type        = string
  default     = null
}
