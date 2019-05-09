#Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
    compartment_id = "${var.compartment_ocid}"
}

# data "oci_core_security_lists" "tajSL" {
#     #Required
#     compartment_id = "${var.compartment_ocid}"
#     vcn_id = "${oci_core_virtual_network.tajVCN.id}"
# }
#
#
# Gets a list of vNIC attachments on the instance
data "oci_core_vnic_attachments" "vnics" {
    compartment_id = "${var.compartment_ocid}"
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
    instance_id = "${oci_core_instance.tajVM.id}"
}

# Gets the OCID of the first (default) vNIC
data "oci_core_vnic" "vnic" {
    vnic_id = "${lookup(data.oci_core_vnic_attachments.vnics.vnic_attachments[0],"vnic_id")}"
}

output "public_ip" {
    value = ["${oci_core_vnic.vnic.public_ip}"]
}
