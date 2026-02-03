resource "aws_eks_cluster" "main" {
  name     = "${local.project}-eks"
  role_arn = var.eks_cluster_role_arn
  version  = var.eks_version

  vpc_config {
    subnet_ids         = concat([for subnet in aws_subnet.public : subnet.id], [for subnet in aws_subnet.private : subnet.id])
    security_group_ids = [aws_security_group.eks_control_plane.id]
    endpoint_public_access = true
    endpoint_private_access = true
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.20.0.0/16"
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]

  tags = merge(local.tags, {
    "Name" = "${local.project}-eks"
  })
}

resource "aws_eks_node_group" "general" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.project}-general"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = [for subnet in aws_subnet.private : subnet.id]

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  instance_types = ["m6i.large"]

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "nodes_cni" {
  role       = element(split("/", var.eks_node_role_arn), length(split("/", var.eks_node_role_arn)) - 1)
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "nodes_worker" {
  role       = element(split("/", var.eks_node_role_arn), length(split("/", var.eks_node_role_arn)) - 1)
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "nodes_ecr" {
  role       = element(split("/", var.eks_node_role_arn), length(split("/", var.eks_node_role_arn)) - 1)
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
