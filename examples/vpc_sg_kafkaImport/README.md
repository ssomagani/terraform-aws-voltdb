# vpc_sg_kafkaImport

This example starts a 3 node VoltDB cluster and a 1 node Kafka cluster. The cluster is highly available with kfactor=1

To setup VoltDB to import from Kafka, VoltDB's Kafka importer should be configured. This configuration is in deployment.xml. The script start-kafka.sh creates the topics that this example uses to push data into VoltDB. The import configuration for importing `events` topic into `events` table and `visits` topic into the `visits` table is alredy in place. 

## Order of operations
1. Start VoltDB and Kafka (Done by the scripts)
2. Load your schema and classes into VoltDB
3. Create the topics on your Kafka cluster
4. Start the Kafka Producer
