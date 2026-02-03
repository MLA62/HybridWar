import os
import yaml


def load_rules(path: str) -> dict:
    with open(path, "r", encoding="utf-8") as handle:
        return yaml.safe_load(handle)


def main() -> None:
    rules_path = os.getenv("RULES_PATH", "/etc/defcon/rules.yaml")
    alerts_topic = os.getenv("ALERTS_TOPIC_ARN", "")
    rules = load_rules(rules_path)
    print(f"[SCORING] Regeln geladen: {rules}")
    print(f"[SCORING] Alerts Topic: {alerts_topic or 'nicht gesetzt'}")


if __name__ == "__main__":
    main()
