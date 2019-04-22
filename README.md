# terraform-aws-voltdb

Terraform Module to build a single VoltDB cluster on AWS. 
The cluster is built from multiple EC2 instances in a single availability zone.

## VoltDB Deployment Configuration
The deployment configuration can be specified by your deployment.xml. Refer to the documentation here - https://docs.voltdb.com/UsingVoltDB/AppxConfigFile.php

## Examples
The vpc_sg example demonstrates building a VoltDB cluster with a custom VPC and Security Group.
