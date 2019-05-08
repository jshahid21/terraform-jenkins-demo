resource "oci_core_instance" "tajVM" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "tajVM"
  image = "${var.InstanceImageOCID[var.region]}"
  shape = "${var.InstanceShape}"

  create_vnic_details {
    subnet_id = "${oci_core_subnet.tajSN.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "tajVM"
  }

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.BootStrapFile))}"
  }

  timeouts {
    create = "60m"
  }
}

data "oci_core_vnic_attachments" "vnics" {
    compartment_id = "${var.compartment_ocid}"
    instance_id = "${oci_core_instance.tajVM.id}"
}

data "oci_core_vnic" "vnic" {
    vnic_id = "${lookup(data.oci_core_vnic_attachments.vnics.vnic_attachments[0],"vnic_id")}"
}

output "public_ip" {
    value = ["${oci_core_vnic.vnic.public_ip_address}"]
}
