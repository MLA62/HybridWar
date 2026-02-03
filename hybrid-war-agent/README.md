# Hybrid War Agent Infrastructure

## Überblick (Deutsch)
Dieses Verzeichnis enthält die IaC- und Deployment-Artefakte für den Hybrid-War-Agenten. Die Struktur bildet die in der Projektbeschreibung geforderten Komponenten ab:

- Terraform-Konfigurationen für AWS (VPC, EKS, S3, Kinesis, OpenSearch, Aurora/Neptune)
- Mermaid-Diagramme zur Visualisierung der Architektur
- Helm-Charts für ETL-, NLP- und Scoring-Jobs
- Dockerfiles und Beispiel-Apps für die AI-Services
- GitHub Actions für Linting, Terraform-Validierung und Pytest
- Konfigurierbare Regeln in `rules.yaml` für die DEFCON-Engine

## Overview (English)
This directory hosts the infrastructure-as-code skeleton and supporting assets for the Hybrid War Agent platform. The layout mirrors the required components described in the project brief:

- Terraform configuration targeting AWS resources (VPC, EKS, S3, Kinesis, OpenSearch, Aurora/Neptune)
- Mermaid diagrams for architecture visualization
- Helm charts for ETL, NLP, and scoring jobs
- Dockerfiles and sample apps for the AI services
- GitHub Actions for linting, Terraform validation, and Pytest
- Configurable rules in `rules.yaml` for the DEFCON engine

## Nächste Schritte / Next Steps
1. Parameter in `terraform/variables.tf` anpassen (Region, Tags, Zugänge).
2. Ressourcen-Details in den einzelnen Terraform-Dateien verfeinern (z.\u202fB. Instance Sizes, Retention, Policies).
3. Helm-Values, Docker-Images und Runtime-Konfigurationen für die Zielumgebung anpassen.
4. Dokumentation in Deutsch und Englisch fortführen.
