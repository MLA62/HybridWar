import os

def main() -> None:
    stream = os.getenv("KINESIS_STREAM", "unknown")
    bucket = os.getenv("RAW_BUCKET", "unknown")
    print(f"[ETL] Starte Ingest: stream={stream}, bucket={bucket}")


if __name__ == "__main__":
    main()
