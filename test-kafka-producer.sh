#!/bin/bash

# broken - just execute the commands manually
# Clone the repository
git clone https://github.com/Aiven-Labs/python-fake-data-producer-for-apache-kafka.git

# Change directory
cd python-fake-data-producer-for-apache-kafka

# Install requirements
pip install -r requirements.txt

git clone https://github.com/dpkp/kafka-python.git
cd kafka-python
pip install .
cd ..


# Run the main.py script
python main.py \
  --security-protocol plaintext \
  --host ${HOST_IP} \
  --port 9092 \
  --topic-name pizza-orders \
  --nr-messages 10 \
  --max-waiting-time 0 \
  --subject pizza