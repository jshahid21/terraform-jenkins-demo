resource "oci_core_instance" "tajVM" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "APEXinstance"
  shape = "${var.InstanceShape}"

  source_details {
      source_type = "image"
      source_id = "${var.InstanceImageOCID[var.region]}"
    }

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

output "public_ip" {
    value = ["${oci_core_vnic.InstanceVnic.public_ip}"]
}
