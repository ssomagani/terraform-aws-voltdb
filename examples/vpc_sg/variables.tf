variable ip_start_offset {
	default = 5
	description = "IP addresses to skip over to account for reserved IPs and possibly marked for other use by application"
}
variable node_count {
	description = "Number of nodes in the cluster"
	default = 1
}
variable access_key {
	description = "AWS Access Key to create resources on your behalf"
}
variable secret_key			{
	description = "AWS Secret Key to create resources on your behalf"
}
variable key_name {
	description = "SSH key to log into the EC2 instances"
}
variable ami {
	description = "Id of VoltDB AMI"
}
variable license_path {
	description = "Path to VoltDB license file on your local machine"
}
variable instance_type {
	description = "Type of EC2 instance"
}
variable ssh_user {
	description = "SSH username"
}
variable key_path {
	description = "Path to the private key"
}
variable vpc_cidr {
	description = "CIDR block for the new VPC"
	default = "10.10.0.0/16"
}
variable subnet_cidr {
	description = "CIDR block for the subnet that VoltDB will be assigned the IP address from"
	default = "10.10.11.0/24"
}
variable cluster {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
	}
}
