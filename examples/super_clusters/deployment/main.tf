data "template_file" "deployment" {
  template = "${file("${path.module}/deployment.tpl")}"
  vars = {
    kfactor = "${var.kfactor}"
    sitesperhost = "${var.sitesperhost}"
    dr_id = "${var.dr_id}"
    source_str = "${var.source_str}"
  }
}

resource "null_resource" "write_deployment" {
  provisioner "local-exec" {
    command = "echo ${join("", data.template_file.deployment.*.rendered)} > deployment-${var.super_cluster_id}-${var.dr_id}.xml"
  }
}
