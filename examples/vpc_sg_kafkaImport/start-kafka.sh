#! /bin/bash

STR=$'\nlisteners=PLAINTEXT://ip-10-10-11-20:9092'
echo "$STR" | sudo tee -a /etc/kafka/server.properties > /dev/null

confluent start kafka

kafka-topics --create --zookeeper localhost:2181  --partitions 1 --replication-factor 1 --topic events
kafka-topics --create --zookeeper localhost:2181  --partitions 1 --replication-factor 1 --topic visits
