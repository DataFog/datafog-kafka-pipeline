ARG IMAGE_VARIANT=slim-buster
ARG OPENJDK_VERSION=8
ARG PYTHON_VERSION=3.9.8

FROM python:${PYTHON_VERSION}-${IMAGE_VARIANT} AS py3
FROM openjdk:${OPENJDK_VERSION}-${IMAGE_VARIANT}

COPY --from=py3 / /

ARG PYSPARK_VERSION=3.2.0
RUN pip --no-cache-dir install --upgrade pip
RUN pip --no-cache-dir install pyspark==${PYSPARK_VERSION}
RUN pip --no-cache-dir install confluent-kafka==1.7.0
RUN pip install presidio-analyzer==2.2.32
RUN pip install presidio-anonymizer==2.2.32
RUN pip install faker
RUN pip install numpy
RUN pip install pandas
RUN pip install requests
RUN pip install spacy
RUN python -m spacy download en_core_web_lg


ENTRYPOINT ["python"]