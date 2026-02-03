resource "aws_s3_bucket" "raw_data" {
  bucket = "${local.project}-${replace(var.aws_region, "-", "")}-raw"

  tags = merge(local.tags, {
    "Name" = "${local.project}-raw"
  })
}

resource "aws_kinesis_stream" "ingest" {
  name             = "${local.project}-ingest"
  shard_count      = var.kinesis_shard_count
  retention_period = 48

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = local.tags
}

resource "aws_security_group" "data_services" {
  name        = "${local.project}-data-sg"
  description = "Zugriff auf Datenbank- und Suchdienste"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Zugriff von EKS Nodes"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.eks_nodes.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    "Name" = "${local.project}-data-sg"
  })
}

resource "aws_db_subnet_group" "aurora" {
  name       = "${local.project}-aurora-subnets"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]

  tags = local.tags
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier = "${local.project}-aurora"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  database_name      = "hybridwar"
  master_username    = var.aurora_master_username
  master_password    = var.aurora_master_password
  storage_encrypted  = true
  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.aurora.name
  vpc_security_group_ids = [aws_security_group.data_services.id]

  tags = local.tags
}

resource "aws_rds_cluster_instance" "aurora" {
  count              = 2
  identifier         = "${local.project}-aurora-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.r6g.large"
  engine             = aws_rds_cluster.aurora.engine
}

resource "aws_neptune_subnet_group" "graph" {
  name       = "${local.project}-neptune-subnets"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]

  tags = local.tags
}

resource "aws_neptune_cluster" "graph" {
  cluster_identifier      = "${local.project}-graph"
  iam_roles               = []
  skip_final_snapshot     = true
  iam_database_authentication_enabled = false

  neptune_subnet_group_name = aws_neptune_subnet_group.graph.name
  vpc_security_group_ids    = [aws_security_group.data_services.id]

  tags = local.tags
}

resource "aws_neptune_cluster_instance" "graph" {
  count              = 1
  cluster_identifier = aws_neptune_cluster.graph.id
  instance_class     = "db.r6g.large"
  engine             = "neptune"
}

resource "aws_opensearch_domain" "threat_intel" {
  domain_name    = "${local.project}-search"
  engine_version = var.opensearch_version

  cluster_config {
    instance_type  = "m6g.large.search"
    instance_count = 2
    zone_awareness_enabled = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 50
    volume_type = "gp3"
  }

  vpc_options {
    security_group_ids = [aws_security_group.data_services.id]
    subnet_ids         = slice([for subnet in aws_subnet.private : subnet.id], 0, 2)
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = false
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  tags = local.tags
}
