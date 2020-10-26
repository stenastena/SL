# Configure the Oracle Cloud Infrastructure provider with an API Key
provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key_path = var.private_key_path
  region = var.region
}


#=================== Get a list of Availability Domains===========================
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
#===================

#===================Create compute instance===========================
#Create a Virtual Cloud Network (VCN)
resource "oci_core_virtual_network" "ExampleVCN" {
  cidr_block = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFExampleVCN"
  dns_label = "tfexamplevcn"
}


#Create a Subnet in Your VCN
resource "oci_core_subnet" "ExampleSubnet" {
  availability_domain = "${var.localAD}"
  cidr_block = "10.1.20.0/24"
  display_name = "TFExampleSubnet"
  dns_label = "tfexamplesubnet"
  security_list_ids = ["${oci_core_virtual_network.ExampleVCN.default_security_list_id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
  route_table_id = "${oci_core_route_table.ExampleRT.id}"
  dhcp_options_id = "${oci_core_virtual_network.ExampleVCN.default_dhcp_options_id}"
}

#Create an Internet Gateway
resource "oci_core_internet_gateway" "ExampleIG" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFExampleIG"
  vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
}

#Create a Core Route Table
resource "oci_core_route_table" "ExampleRT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
  display_name = "TFExampleRouteTable"
  route_rules {
    cidr_block = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.ExampleIG.id}"
  }
}

#Create a Compute Instance
resource "oci_core_instance" "TFInstance" {
  count = "${var.NumInstances}"
  availability_domain = "${var.localAD}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFInstance${count.index}"
  shape = "${var.InstanceShape}"
 
  create_vnic_details {
    subnet_id = "${oci_core_subnet.ExampleSubnet.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "tfexampleinstance${count.index}"
  }
 
  source_details {
    source_type = "image"
    source_id = "${var.InstanceImageOCID[var.region]}"
 
    # Apply this to set the size of the boot volume that's created for this instance.
    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    #boot_volume_size_in_gbs = "60"
  }


    # Apply the following flag only if you wish to preserve the attached boot volume upon destroying this instance
  # Setting this and destroying the instance will result in a boot volume that should be managed outside of this config.
  # When changing this value, make sure to run 'terraform apply' so that it takes effect before the resource is destroyed.
  #preserve_boot_volume = true
 
  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
  
  }
  timeouts {
    create = "60m"
  }
}

################ Database ##################
resource "oci_database_autonomous_database" "test_autonomous_database" {
    #Required
    compartment_id = var.compartment_ocid
    cpu_core_count = var.autonomous_database_cpu_core_count
    data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
    db_name = var.autonomous_database_db_name

    #Optional
    admin_password = var.autonomous_database_admin_password
    db_version = var.autonomous_database_db_version
    db_workload = var.autonomous_database_db_workload
    display_name = var.autonomous_database_display_name
    freeform_tags = {"Department"= "Finance"}
    is_free_tier = var.autonomous_database_is_free_tier
    license_model = var.autonomous_database_license_model
    source = var.autonomous_database_source
    #autonomous_container_database_id = oci_database_autonomous_container_database.test_autonomous_container_database.id
    #autonomous_database_backup_id = oci_database_autonomous_database_backup.test_autonomous_database_backup.id
    ##autonomous_database_id = oci_database_autonomous_database.test_autonomous_database.id
    #clone_type = var.autonomous_database_clone_type
    #data_safe_status = var.autonomous_database_data_safe_status
    #defined_tags = var.autonomous_database_defined_tags
    #is_auto_scaling_enabled = var.autonomous_database_is_auto_scaling_enabled
    #is_data_guard_enabled = var.autonomous_database_is_data_guard_enabled
    #is_dedicated = var.autonomous_database_is_dedicated
    #is_preview_version_with_service_terms_accepted = var.autonomous_database_is_preview_version_with_service_terms_accepted
    #nsg_ids = var.autonomous_database_nsg_ids
    #private_endpoint_label = var.autonomous_database_private_endpoint_label
    #refreshable_mode = var.autonomous_database_refreshable_mode
    #source_id = oci_database_source.test_source.id
    #subnet_id = oci_core_subnet.test_subnet.id
    #timestamp = var.autonomous_database_timestamp
    #whitelisted_ips = var.autonomous_database_whitelisted_ips
}