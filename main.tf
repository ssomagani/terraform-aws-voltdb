resource "aws_instance" volt {
  count				= "${var.node_count}"
  ami				= "${var.ami}"
  availability_zone 		= "${var.zone}"
  instance_type 		= "${var.instance_type}"
  key_name			= "${var.key_name}"
  private_ip 			= "${cidrhost(var.subnet_cidr_block, count.index + var.ip_start_offset)}"
  subnet_id			= "${var.subnet_id}"
  #vpc_security_group_ids 	= "${var.security_group_ids}"
  vpc_security_group_ids = ["${split(";", var.security_group_ids)}"]

  provisioner "file" {
	source			= "${var.deployment_file}",
	destination 		= "/home/ubuntu/deployment.xml"
	connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
    }
  }
  
  provisioner "file" {
    source      		= "${path.module}/start-volt-cluster.sh"
    destination 		= "/home/ubuntu/start-volt-cluster.sh"
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
}

resource "null_resource" "copy_license" {
	count			= "${var.license_path == "" ? 0 : var.node_count}"
	provisioner "file" {
	source			= "${var.license_path}",
	destination 		= "/opt/voltdb/voltdb/license.xml"
	connection {
	  host     		= "${element(aws_instance.volt.*.public_ip, count.index)}"
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
    }
  }
  depends_on			= ["aws_instance.volt"]
}

resource "null_resource" "start-volt-cluster" {
  count				= "${var.node_count}"
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/start-volt-cluster.sh",
      "/home/ubuntu/start-volt-cluster.sh ${var.node_count} ${var.host_string_self} > startup.log",
      # Without a sleep, process gets killed before it even starts     
      "sleep 1"
    ]
    connection {
	  host     		= "${element(aws_instance.volt.*.public_ip, count.index)}"
      type     			= "ssh"
      user    			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
	depends_on		= ["null_resource.copy_license"]
}
