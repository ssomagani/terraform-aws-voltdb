variable ip_start_offset {
	default = 5
	description = "IP addresses to skip over to account for reserved IPs and possibly marked for other use by application"
}

variable access_key {
	description = "AWS Access Key to create resources on your behalf"
}
variable secret_key	{
	description = "AWS Secret Key to create resources on your behalf"
}
variable key_name {
	description = "SSH key to log into the EC2 instances"
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
	default = "192.168.0.0/16"
}
variable cluster-1-1 {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
		node_count = 3
		subnet_cidr = "192.168.1.0/24"
	}
}
variable cluster-1-2 {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
		node_count = 3
		subnet_cidr = "192.168.2.0/24"
	}
}
variable cluster-1-3 {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
		node_count = 3
		subnet_cidr = "192.168.3.0/24"
	}
}

variable super-cluster-1 {
  type = "map"
  default = {
    ami = "ami-054e818a627ed97bc"
    zone = "us-east-1b"
  }
}

variable super-cluster-2 {
  type = "map"
  default = {
    ami = "ami-00327684cb1cf603c"
    zone = "us-west-2b"
  }
}
variable cluster-2-1 {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
		node_count = 3
		subnet_cidr = "192.168.4.0/24"
	}
}
variable cluster-2-2 {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
		node_count = 3
		subnet_cidr = "192.168.5.0/24"
	}
}
variable cluster-2-3 {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
		node_count = 3
		subnet_cidr = "192.168.6.0/24"
	}
}