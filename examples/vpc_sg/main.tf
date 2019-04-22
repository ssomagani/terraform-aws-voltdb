provider "aws" {
  access_key				= "${var.access_key}"
  secret_key				= "${var.secret_key}"
  region     				= "us-east-1"
}

module "vpc" {
	source				= "terraform-aws-modules/vpc/aws"
	name = "vpc"
	cidr				= "${var.vpc_cidr}"
	azs 					= ["us-east-1b"]
	public_subnets			= ["${var.subnet_cidr}"]
	map_public_ip_on_launch = "true"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  tags = {
  	Name = "allow_all"
  }
}

data "template_file" "ips_1" {
	count 				= "${var.node_count}"
	template			= "$${cidrhost("${var.subnet_cidr}", ${count.index} + ${var.ip_start_offset})}"
}

locals {
	  host_string_1 	= "${join(",", data.template_file.ips_1.*.rendered)}"
}

module "volt" {
	source 				= "../../../terraform-aws-voltdb"
	zone			 	= "us-east-1b"
	subnet_id 			= "${element(module.vpc.public_subnets, 0)}"
	subnet_cidr_block		= "${var.subnet_cidr}"
	ip_start_offset			= "${var.ip_start_offset}"
	security_group_id 		= "${aws_security_group.allow_all.id}"
	host_string_self			= "${local.host_string_1}"
	ami					= "${var.ami}"
	node_count			= "${var.node_count}"
	instance_type		= "${var.instance_type}"
	license_path		= "${var.license_path}"
	key_name		= "${var.key_name}"
	ssh_user		= "${var.ssh_user}"
	key_path		= "${var.key_path}"
	deployment_file = "deployment.xml"
}
