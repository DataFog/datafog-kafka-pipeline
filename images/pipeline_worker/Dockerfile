# Stage 1: Base image with Python 3.10.11
FROM python:3.10.11 as base

RUN apt-get update && apt-get install -y git
RUN apt install librdkafka-dev -y

RUN set -ex; \
  python -m pip install --upgrade pip; \
  pip install faker numpy pandas confluent-kafka requests fastavro uuid

# Stage 2: Install Presidio packages
FROM base as presidio

RUN pip install presidio-analyzer==2.2.32
RUN pip install presidio-anonymizer==2.2.32

# Stage 3: Install Kafka-Python
FROM presidio as kafka-python

RUN git clone https://github.com/dpkp/kafka-python.git
WORKDIR /kafka-python
RUN pip install .
WORKDIR /

# Stage 4: Install additional packages
FROM kafka-python as final

RUN pip3 install avro cryptography spacy

RUN python -m spacy download en_core_web_lg