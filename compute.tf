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

data "oci_core_instance" "tajVM" {
    #Required
    instance_id = "${oci_core_instance.tajVM.instance_id.id}"
    public_ip = "${oci_core_instance.tajVM.public_ip.id}"
}


output "oci_core_instance" "tajVM" {
    value = ["${oci_core_instance.tajVM.public_ip}"]
}
