import os

def main() -> None:
    model = os.getenv("MODEL_NAME", "unknown")
    index = os.getenv("OUTPUT_INDEX", "unknown")
    print(f"[NLP] Verwende Modell {model} für Index {index}")


if __name__ == "__main__":
    main()
