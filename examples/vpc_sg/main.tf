provider "aws" {
  access_key				= "${var.access_key}"
  secret_key				= "${var.secret_key}"
  region     				= "us-east-1"
}

module "vpc" {
	source					= "terraform-aws-modules/vpc/aws"
	name = "vpc"
	cidr					= "${var.vpc_cidr}"
	azs 					= ["us-east-1b"]
	public_subnets			= ["${var.subnet_cidr}"]
	map_public_ip_on_launch = "true"
}

resource "aws_security_group" "allow_22_8080_3021" {
  name        = "allow_22_8080_3021"
  description = "Allow all inbound TCP traffic on ports 22, 8080 and subnet-only traffic on 3021 and 21212"
  vpc_id      = "${module.vpc.vpc_id}"

  # Public ports
  # SSH
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # XDCR
  ingress {
    from_port   = "5555"
    to_port     = "5555"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  # TLS
  ingress {
    from_port   = "8443"
    to_port     = "8443"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTP
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Admin
  ingress {
  	from_port   = "21211"
    to_port     = "21211"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Client
  ingress {
  	from_port   = "21212"
    to_port     = "21212"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Private ports

  # Internal Server  
  ingress {
  	from_port   = "3021"
    to_port     = "3021"
    protocol    = "TCP"
    cidr_blocks = ["${var.subnet_cidr}"]
  }
    
  egress {
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  tags = {
  	Name = "allow_22_8080_3021"
  }
}

data "template_file" "ips_1" {
	count 				= "${var.node_count}"
	template			= "$${cidrhost("${var.subnet_cidr}", ${count.index} + ${var.ip_start_offset})}"
}

module "volt" {
	source 				= "ssomagani/voltdb/aws"
	zone			 	= "us-east-1b"
	subnet_id 			= "${element(module.vpc.public_subnets, 0)}"
	subnet_cidr_block		= "${var.subnet_cidr}"
	ip_start_offset			= "${var.ip_start_offset}"
	security_group_id 		= "${aws_security_group.allow_22_8080_3021.id}"
	host_string_self			= "${join(",", data.template_file.ips_1.*.rendered)}"
	ami					= "${var.ami}"
	node_count			= "${var.node_count}"
	instance_type		= "${var.instance_type}"
	license_path		= "${var.license_path}"
	key_name		= "${var.key_name}"
	ssh_user		= "${var.ssh_user}"
	key_path		= "${var.key_path}"
	deployment_file = "deployment.xml"
}
