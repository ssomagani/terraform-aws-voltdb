# xdcr_vpc_sg
This example creates two VoltDB super-clusters with each super-cluster containing 3 clusters connected by XDCR

## How to run
`terraform apply -var-file=values.tfvars -var-file=path/to/aws_keys.tfvars`

## TODO
Setup VPC peering so that clusters within a super cluster can communicate even when they are in different regions
