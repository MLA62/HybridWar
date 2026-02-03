from pathlib import Path

import yaml


def test_rules_weights_sum_to_one() -> None:
    rules_path = Path(__file__).resolve().parents[2] / "rules.yaml"
    data = yaml.safe_load(rules_path.read_text(encoding="utf-8"))
    weights = data["weights"]
    assert round(sum(weights.values()), 2) == 1.0


def test_defcon_thresholds_ordered() -> None:
    rules_path = Path(__file__).resolve().parents[2] / "rules.yaml"
    data = yaml.safe_load(rules_path.read_text(encoding="utf-8"))
    thresholds = data["thresholds"]
    assert thresholds["defcon5"] < thresholds["defcon4"] < thresholds["defcon3"] < thresholds["defcon2"] < thresholds["defcon1"]
