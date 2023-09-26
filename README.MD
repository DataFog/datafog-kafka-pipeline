# datafog-api
The api part is purely aspirational at this point - right now it's just standing up the spark and kafka containers. 



# Pipeline Checklist
- [] Run docker-compose up --build
- [] Create input and output topics
- [] Run PII Schema Inference
- [] Run DeID Pipeline
- [] (Optional) Run ReID Pipeline 
- [] Check output topic to make sure it looks right

Right now the specific pipeline steps are done by executing commands within specific containers (see below). 

# Sending Test Messages
I have been using the https://github.com/Aiven-Labs/python-fake-data-producer-for-apache-kafka to send test messages to the kafka server. You can use the following command to send messages to the server:

```
./test-kafka-producer.sh
```



# Setup
1. Clone Repo
2. Run `docker-compose up --build' in the root directory
3. Start a new screen to execute commands in the docker container

# Commands

**View All Topics**

```
docker-compose exec kafka kafka-topics --list --zookeeper zookeeper:2181
```
**Create New Topic**

```
docker-compose exec kafka kafka-topics --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic sidmo
```
Note: you should create a new input topic and a new output topic before sending messages to the server. (so in the example above you'd run another command to create an output topic to write the deid messages to, like sidmo_deid)
TODO: create a script to create a new output topic automatically to skip this

**Delete Topic**

```
docker-compose exec kafka kafka-topics --delete --zookeeper zookeeper:2181 --topic sidmo
```

**View All Messages for a Topic**

```
docker-compose exec kafka kafka-console-consumer --bootstrap-server kafka:9092 --topic sidmo --from-beginning
```

**Run PII Schema Inference**

```
docker-compose exec spark-master spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /opt/app/pii_schema_inf/pii_schema_inf.py
```

**Run DeID Pipeline**
    
``` 
sudo docker exec -it pipeline_worker python -c "from deid import run_deid_pipeline; run_deid_pipeline('schema_name', 'topic_input', 'topic_output', 'key_name')"
```
schema_name: name of the schema to use
topic_input: topic to read from
topic_output: topic to write to
key_name: name of the key to use for the output topic

You should check the messages in the output topic to make sure they are correct.

**Run ReID Pipeline**

```
sudo docker exec -it pipeline_worker python -c "from reid import run_reid_pipeline; run_reid_pipeline('schema_name', 'topic_input', 'topic_output', 'key_name')"
```

note that topic_input and topic_output are the opposite semantically from the deid pipeline. topic_input is the topic to read from, and topic_output is the topic to write to. 
