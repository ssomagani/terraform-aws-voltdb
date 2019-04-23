# terraform-aws-voltdb

Terraform Module to build a VoltDB v8.4.1 cluster on an Ubuntu 18.04 EC2 instance. 
The cluster is built from multiple EC2 instances in a single availability zone.
Cluster of multiple nodes can be provisioned by simply setting the node_count input variable

## VoltDB Deployment Configuration
The deployment configuration can be specified by your deployment.xml. Refer to the documentation here - https://docs.voltdb.com/UsingVoltDB/AppxConfigFile.php

## Examples
*vpc_sg demonstrates building a VoltDB cluster with a custom VPC and Security Group.
*vpc_sg_kafkaImport goes one step further and demonstrates import of events from Kafka into VoltDB
