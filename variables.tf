variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC25Yy2dfp1MMwrF4E/Xr2aiXnWw9fi6qA91q+lSFv8Bu9Prx3XiwMHoe5Jd1GcjrIyCqt3Crz1MCXFaCxen+r/ByUIPaGNKr78FPARqL6R6HO4yQJXva9Qn/PBdakui75fTUMs6uyK3vWSd9cEDEn026DRbi7WbFmXcY8TbeZuboSsps7jY2Lrs6I+/N9x3DpDEm68P8TKVyAPGtQAEIb1bhecwfIJFzSXpMdpTTMD5RJKlugKcqVURN5EwFLn0XBgRqDMy3jNma1h5lvVvSqQtT80o8Kl/JMzr4hVyNAUjsat2ChrH0emQ0Gef3bjQMI0GF6hpA3e15l6yuupXVKr id_rsa"
}

# Choose an Availability Domain
variable "AD" {
    default = "2"
}

variable "InstanceShape" {
    default = "VM.Standard2.1"
}
#
variable "InstanceImageOCID" {
    type = "map"
    default = {
        // Oracle-provided image "Oracle-Linux-7.4-2018.01.20-0"
        // See https://docs.us-phoenix-1.oraclecloud.com/Content/Resources/Assets/OracleProvidedImageOCIDs.pdf
                    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaacvcy3avanrdb4ida456dgktfhab2phyaikmw75yflugq37eu6oya"
                    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaavzrrzlq2zvj5fd5c27jed7fwou5aqkezxbtmys4aolls54zg7f7q"
                    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaandary2dpwhw42xgv2d3zsbax2hln4wgcrm2tulo3dg67mwkly6aq"
    }
}

# variable "DBSize" {
#     default = "50" // size in GBs
# }

variable "BootStrapFile" {
    default = "./userdata/bootstrap"
}
