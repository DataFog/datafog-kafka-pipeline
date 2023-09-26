#!/bin/bash

# Clone the repository
git clone https://github.com/Aiven-Labs/python-fake-data-producer-for-apache-kafka.git

# Change directory
cd python-fake-data-producer-for-apache-kafka

# Install requirements
pip install -r requirements.txt

# Run the main.py script
python main.py \
  --security-protocol plaintext \
  --host ${HOST_IP} \
  --port 9092 \
  --topic-name pizza-orders \
  --nr-messages 10 \
  --max-waiting-time 0 \
  --subject pizza