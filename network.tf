resource "oci_core_virtual_network" "tajVCN" {
  cidr_block = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name = "tajVCN"
  dns_label = "tajVCN"
}

resource "oci_core_subnet" "tajSN" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.20.0/24"
  display_name = "tajSN"
  dns_label = "tajSN"
  security_list_ids = ["${oci_core_security_list.tajSL.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tajVCN.id}"
  route_table_id = "${oci_core_route_table.tajRT.id}"
  dhcp_options_id = "${oci_core_virtual_network.tajVCN.default_dhcp_options_id}"
}

resource "oci_core_internet_gateway" "tajIG" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "tajIG"
  vcn_id = "${oci_core_virtual_network.tajVCN.id}"
}

resource "oci_core_route_table" "tajRT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tajVCN.id}"
  display_name = "tajRT"
  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.tajIG.id}"
  }
}

resource "oci_core_security_list" "tajSL" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tajVCN.id}"
  display_name = "tajSL"
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 22
      "max" = 22
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = false

    icmp_options {
      "type" = 3
      "code" = 4
    }
  }

  ingress_security_rules {
    protocol  = 1
    source    = "10.0.0.0/16"
    stateless = false

    icmp_options {
      "type" = 3
      "code" = 4
    }
  }
  ingress_security_rules {
    protocol  = 6
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 80
      "max" = 80
    }
  }
  ingress_security_rules {
    protocol  = 6
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 8888
      "max" = 8888
    }
  }
  ingress_security_rules {
    protocol  = 6
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 8080
      "max" = 8080
    }
  }
  ingress_security_rules {
    protocol  = 6
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 2222
      "max" = 2222
    }
  }
}
