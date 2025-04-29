# Hello Kafka Data Pipelines

A modular data pipeline using **Apache Kafka**, **Apache Spark Structured Streaming**, and **Cassandra**. This project demonstrates real-time data ingestion from Kafka, processing with Spark, and storage in Cassandra.

---

## Architecture

```
Kafka Producer → Kafka Topic → Spark Structured Streaming → Cassandra
```
- **Kafka**: Handles real-time event streaming.
- **Spark**: Reads from Kafka, processes data, writes to Cassandra.
- **Cassandra**: Stores processed data for fast querying.

---

## Prerequisites

- Python 3.12+
- Docker & Docker Compose
- [pip](https://pip.pypa.io/en/stable/)

---

## Setup

1. **Clone the repository**
```bash
   git clone <repo-url>
   cd hello-kafka-data-pipelines
```

2. **Install Python dependencies**
   
```bash
  uv venv
  source .venv/bin/activate 
  uv sync
 ```

3. **Start Kafka and Cassandra using Docker Compose**
   ```bash
   docker-compose up -d
   ```
   This will start Kafka (on `localhost:9092`) and Cassandra (on `localhost:9042`).

---

## Running the Pipeline

1. **Run the Spark Streaming Job**
   ```bash
   uv run stream_spark.py
   ```
   - The Spark job will connect to Kafka and Cassandra on `localhost`.
   - If running Spark inside Docker, adjust the hostnames as needed.

2. **Produce data to Kafka**
   - dags/kafka_stream.py.

---

## Key Configuration

- **Cassandra Host**: Ensure Spark and the Cassandra Python driver both use `localhost` as the host if running on your machine. If running in Docker, use the service name (e.g., `cassandra`).
- **Kafka Bootstrap Servers**: Default is `localhost:9092`.
- **Kafka config** http://localhost:9021/
- **Apache Airflow** http://localhost:8080/
---

## Verify Data in Cassandra
```bash
docker exec -it cassandra_db cqlsh -u cassandra -p cassandra
```

```sql
USE spark_streams;
SELECT * FROM created_users;
```

## Troubleshooting

- **Cassandra connection errors**: Double-check that Cassandra is running and accessible on `localhost:9042`.
- **Kafka connection errors**: Ensure Kafka is up and the topic exists.
- **Host resolution issues**: If you see errors about `UnknownHostException`, ensure your hostnames are ASCII and `/etc/hosts` is correct.
- **Logging**: Error logs will print detailed connection issues for easier debugging.

---

## Modularity & Best Practices

- Code is organized for clarity and reusability.
- Configuration is kept simple and in-code for demo purposes.
- Keep files under 200 lines and avoid monolithic scripts.

---

## License

MIT
