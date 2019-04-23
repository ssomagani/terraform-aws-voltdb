variable name { 
	default = "volt"
	description = "Name of this VoltDB resource for reference in your TF scripts"
}

variable license_path { 
	description = "Path to the license file to run VoltDB Enterprise. Ignore this if your image has a valid license baked in already."
}

variable key_name {
	description = "Key to use for SSH into this resource"
}

variable key_path { 
	description = "Local path to the private key" 
}

variable ssh_user { 
	description = "SSH user" 
}

variable subnet_cidr_block {
	description = "The Subnet IPs to use for creation of one or more VoltDB resources"
}

variable ami {
	description = "The VoltDB AMI" 
}

variable node_count {
	description = "The number of VoltDB nodes in the cluster"
}

variable instance_type {
	description = "Type of AWS instance for each VoltDB node"
}

variable zone {
	description = "The AWS availability zone for these EC2 instances"
}

variable subnet_id {
	description = "The subnet for the EC2 instances"
}

variable security_group_id {
	description = "Security Group for the EC2 instances"
}

variable ip_start_offset {
	description = "IP addresses to skip over to account for reserved IPs and possibly marked for other use by application"
}

variable host_string_self {
	description = "A comma separated list of hostnames/ips of all the EC2 instances in this VoltDB cluster. This string is passed as an argument to the `voltdb start` command."
}

variable deployment_file {
	description = "Path to the VoltDB deployment file"
}
