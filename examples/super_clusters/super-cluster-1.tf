provider "aws" {
  access_key				= "${var.access_key}"
  secret_key				= "${var.secret_key}"
  region     				= "us-east-1"
}

module "vpc-1" {
  source					= "terraform-aws-modules/vpc/aws"
  name = "vpc"
  cidr					= "${var.vpc_cidr}"
  azs 					= ["${var.super-cluster-1["zone"]}"]
  public_subnets			= ["${var.cluster-1-1["subnet_cidr"]}","${var.cluster-1-2["subnet_cidr"]}","${var.cluster-1-3["subnet_cidr"]}"]
  map_public_ip_on_launch = "true"
}

module "sg-1" {
  source = "./sg"
  vpc_id = "${module.vpc-1.vpc_id}"
  private_cidr_blocks = "${var.cluster-1-1["subnet_cidr"]};${var.cluster-1-2["subnet_cidr"]};${var.cluster-1-3["subnet_cidr"]}"
}

data "template_file" "ips-1-1" {
	count 				= "${var.cluster-1-1["node_count"]}"
	template			= "$${cidrhost("${var.cluster-1-1["subnet_cidr"]}", ${count.index} + ${var.ip_start_offset})}"
}

data "template_file" "ips-1-2" {
	count 				= "${var.cluster-1-2["node_count"]}"
	template			= "$${cidrhost("${var.cluster-1-2["subnet_cidr"]}", ${count.index} + ${var.ip_start_offset})}"
}

data "template_file" "ips-1-3" {
	count 				= "${var.cluster-1-3["node_count"]}"
	template			= "$${cidrhost("${var.cluster-1-3["subnet_cidr"]}", ${count.index} + ${var.ip_start_offset})}"
}

locals {
	  host_string-1-1 	= "${join(",", data.template_file.ips-1-1.*.rendered)}"
	  host_string-1-2 	= "${join(",", data.template_file.ips-1-2.*.rendered)}"
	  host_string-1-3 	= "${join(",", data.template_file.ips-1-3.*.rendered)}"
}

module "deployment-file-1-1" {
  source = "./deployment"
  super_cluster_id = "1"
  node_count = "${var.cluster-1-1["node_count"]}"
  subnet_cidr = "${var.cluster-1-1["subnet_cidr"]}"
  kfactor = "${var.cluster-1-1["kfactor"]}"
  sitesperhost = "${var.cluster-1-1["sitesperhost"]}"
  dr_id = "1"
  source_str = "${local.host_string-1-2},${local.host_string-1-3}"
  ip_start_offset			= "${var.ip_start_offset}"
}

module "deployment-file-1-2" {
  source = "./deployment"
  super_cluster_id = "1"
  node_count = "${var.cluster-1-2["node_count"]}"
  subnet_cidr = "${var.cluster-1-2["subnet_cidr"]}"
  kfactor = "${var.cluster-1-2["kfactor"]}"
  sitesperhost = "${var.cluster-1-2["sitesperhost"]}"
  dr_id = "2"
  source_str = "${local.host_string-1-1},${local.host_string-1-3}"
  ip_start_offset			= "${var.ip_start_offset}"
}

module "deployment-file-1-3" {
  source = "./deployment"
  super_cluster_id = "1"
  node_count = "${var.cluster-1-3["node_count"]}"
  subnet_cidr = "${var.cluster-1-3["subnet_cidr"]}"
  kfactor = "${var.cluster-1-3["kfactor"]}"
  sitesperhost = "${var.cluster-1-3["sitesperhost"]}"
  dr_id = "3"
  source_str = "${local.host_string-1-2},${local.host_string-1-1}"
  ip_start_offset			= "${var.ip_start_offset}"
}

module "volt-cluster-1-1" {
	source 				= "../../"
	zone			 	= "${var.super-cluster-1["zone"]}"
	subnet_id 			= "${element(module.vpc-1.public_subnets, 0)}"
	subnet_cidr_block		= "${var.cluster-1-1["subnet_cidr"]}"
	ip_start_offset			= "${var.ip_start_offset}"
	security_group_ids 		= "${module.sg-1.voltdb_private_id};${module.sg-1.voltdb_public_id}"
	host_string_self			= "${local.host_string-1-1}"
	ami					= "${var.super-cluster-1["ami"]}"
	node_count			= "${var.cluster-1-1["node_count"]}"
	instance_type		= "${var.instance_type}"
	license_path		= "${var.license_path}"
	key_name		= "${var.key_name}"
	ssh_user		= "${var.ssh_user}"
	key_path		= "${var.key_path}"
	deployment_file = "deployment-1-1.xml"
}

module "volt-cluster-1-2" {
	source 				= "../../"
	zone			 	= "${var.super-cluster-1["zone"]}"
	subnet_id 			= "${element(module.vpc-1.public_subnets, 1)}"
	subnet_cidr_block		= "${var.cluster-1-2["subnet_cidr"]}"
	ip_start_offset			= "${var.ip_start_offset}"
	security_group_ids 		= "${module.sg-1.voltdb_private_id};${module.sg-1.voltdb_public_id}"
	host_string_self			= "${local.host_string-1-2}"
	ami					= "${var.super-cluster-1["ami"]}"
	node_count			= "${var.cluster-1-2["node_count"]}"
	instance_type		= "${var.instance_type}"
	license_path		= "${var.license_path}"
	key_name		= "${var.key_name}"
	ssh_user		= "${var.ssh_user}"
	key_path		= "${var.key_path}"
	deployment_file = "deployment-1-2.xml"
}

module "volt-cluster-1-3" {
	source 				= "../../"
	zone			 	= "${var.super-cluster-1["zone"]}"
	subnet_id 			= "${element(module.vpc-1.public_subnets, 2)}"
	subnet_cidr_block		= "${var.cluster-1-3["subnet_cidr"]}"
	ip_start_offset			= "${var.ip_start_offset}"
	security_group_ids 		= "${module.sg-1.voltdb_private_id};${module.sg-1.voltdb_public_id}"
	host_string_self			= "${local.host_string-1-3}"
	ami					= "${var.super-cluster-1["ami"]}"
	node_count			= "${var.cluster-1-3["node_count"]}"
	instance_type		= "${var.instance_type}"
	license_path		= "${var.license_path}"
	key_name		= "${var.key_name}"
	ssh_user		= "${var.ssh_user}"
	key_path		= "${var.key_path}"
	deployment_file = "deployment-1-3.xml"
}
