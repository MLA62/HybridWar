# Hybrid-War-Agent


Ein autonomes Recherchier- und Analyse-Tool für hybride Angriffe (Cyber, Desinformation, GNSS-Störungen, Lieferketten).


## Ziele
- Sammeln von Daten aus News, CERT-Feeds, Social Media, OSINT
- Analyse von Texten mit AI (GPT API)
- Abgleich von IOCs/TTPs mit MITRE ATT&CK
- Berechnung von DEFCON-Level (5 bis 1)
- Dashboard und Alerts (SNS/Slack/E-Mail)


## Architektur
- Infrastruktur via Terraform (AWS: VPC, EKS, S3, Kinesis, OpenSearch, Aurora/Neptune)
- Workloads in Kubernetes (ETL, NLP, Scoring)
- AI-Komponenten in Python
- Dashboard mit Grafana


## Installation
1. Repository klonen
2. Terraform init/apply
3. Docker-Images bauen und in Registry pushen
4. Helm Charts deployen


## Nutzung
- Dashboard öffnen (Grafana)
- DEFCON-Level und Alerts prüfen
- Events und KB-Abfragen via API


## Sicherheit
- Secrets im AWS Secrets Manager
- IAM Least Privilege
- Audit Logs via CloudTrail


## Tests
- Unit Tests (Scoring, NLP)
- Integrationstests (ETL)
- Load Tests (Ingestion)
- Security Tests (IAM, Netzwerk)


## Lizenz
Apache 2.0 oder MIT
