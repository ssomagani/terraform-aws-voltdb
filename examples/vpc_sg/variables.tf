variable ip_start_offset {
	default = 5
	description = "IP addresses to skip over to account for reserved IPs and possibly marked for other use by application"
}

variable node_count {
	description = "Number of nodes in the cluster"
	default = 1
}
variable access_key 			{ }
variable secret_key			{ }
variable key_name 			{ }
variable ami {}

variable license_path { }
variable instance_type { }
variable ssh_user { }
variable key_path {}

variable vpc_cidr {
	default = "10.10.0.0/16"
}

variable subnet_cidr {
	default = "10.10.11.0/24"
}

variable cluster {
	type = "map"
	default = {
		kfactor = "1"
		sitesperhost = "8"
	}
}

variable import {
	type = "map"
	default = {
		variable configuration {
			type = "map"
			default = {
				format = "csv"
			}
		}
	}
}
