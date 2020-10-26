variable "tenancy_ocid" {
  type = string
  default = "ocid1.tenancy.oc1..aaaaaaaar3cuxj4cred3h6jjevhan2zzgd6jymq2lq7mdutyzpy5jg3i3qca"
  description = " "
}
variable "user_ocid" {
  type = string
  default = "ocid1.user.oc1..aaaaaaaalzo3fx7wualribaopagqtu3i5qki2wdhumggoynzui4bpve75vaq"
  description = ""
}
variable "fingerprint" {
  type = string
  default = "69:b3:0c:dc:31:ee:77:c1:84:ec:39:ea:35:c7:d6:a4"
  description = " "
}
variable "private_key_path" {
  type = string
  default = "C:/Users/osherovsy/.oci/oci_api_key.pem"
  description = ""
}
variable "region" {
  type = string
  default = "eu-frankfurt-1"
  description = ""
}

###########################################
variable "compartment_ocid" {
	default = "ocid1.compartment.oc1..aaaaaaaa2llo3rlerosipzxx3md7huzz35hpvxydgjxkdnugfcoy2tgeuwcq"
}

variable "InstanceImageOCID" {
############# The admin by default - opc

  type = "map"
  
  default = {
    // See https://docs.cloud.oracle.com/images/
    // Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    
    "eu-frankfurt-1" = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaitzn6tdyjer7jl34h2ujz74jwy5nkbukbh55ekp6oyzwrtfa4zma"
    "uk-london-1" = "ocid1.image.oc1.uk-london-1.aaaaaaaa32voyikkkzfxyo4xbdmadc2dmvorfxxgdhpnk6dw64fa3l4jh7wa"
    "us-ashburn-1" = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    "us-phoenix-1" = "ocid1.image.oc1.phx.aaaaaaaaoqj42sokaoh42l76wsyhn3k2beuntrh5maj3gmgmzeyr55zzrwwa"
  }
}


variable "ssh_public_key" {
	default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUGqIflQOp0CuhaEn3wDlWRvWwiRfNyCeBxysIZOvBuDrys949rjmeBbAJsBDeFqfj5Cj40cqivDyi8jO3iiRz+GWhrkHqqm1arRSKMuRe7+QQdkNWn2QKzzT+lcqnOuuZCqECXg2Fmk0styWdoHe/m2q/RkjSRa/UDw8b64Bt7ubXvrNh6cGWvfSGCfDBUKkfg3LS+N/ohKoXqfqAv5mnJk8bz+SOvCRIbVXaor91yYNuP+4jsOtFCnPeTAaNDSRo0aktFEPdU4NS5i5FP1MDX28jD3l3GORo9NtUnmv5+XB5pIULtRjAtAXDcmapJ8X6HWVU2idBBI3XoRtk+v6l superadmin@MSK14-N0287"
}

# Defines the number of instances to deploy
variable "NumInstances" {
    default = "1"
}

variable "InstanceShape" {
#    default = "VM.Standard.E2.1.Micro"
    default = "VM.Standard.E2.1"
}

# Specifies the Availability Domain
variable "localAD" {
    default = "cYQm:EU-FRANKFURT-1-AD-3"
}

################### Variables for Oracle database ###########

# Requred
variable "autonomous_database_cpu_core_count" {
  default = 1
  type = string
  description = "(optional) describe your variable"
}

variable "autonomous_database_data_storage_size_in_tbs" {
  default = "1"
  type = string
  description = "(optional) describe your variable"
}

variable "autonomous_database_db_name" {
  default = "mydb149149"
  type = string
  description = "(optional) describe your variable"
}

# Optional

variable "autonomous_database_admin_password" {
  ##### The username for the Service Console is ADMIN. Use the password you entered when creating the Autonomous Database for the password value. 
  default = "1q21!Q@!1q21"
  type = string
  description = "(optional) describe your variable"
}

variable "autonomous_database_is_free_tier" {
  default = "true"
  type = string
  description = "Indicates if this is an Always Free resource. The default value is false. Note that Always Free Autonomous Databases have 1 CPU and 20GB of memory. For Always Free databases, memory and CPU cannot be scaled."
}

variable "autonomous_database_db_version" {
  default = "19c"
  type = string
  description = "(Optional) (Updatable) A valid Oracle Database version for Autonomous Database.db_workload AJD is only supported for db_version 19c and above."
}


variable "autonomous_database_db_workload" {
  default = "OLTP"
  type = string
  description = <<EOF
  (Optional) (Updatable) The Autonomous Database workload type. The following values are valid:
OLTP - indicates an Autonomous Transaction Processing database
DW - indicates an Autonomous Data Warehouse database
AJD - indicates an Autonomous JSON Database *Note: db_workload can only be updated from AJD to OLTP or from a free OLTP to AJD.
EOF
}

variable "autonomous_database_display_name" {
  default = "My Oracle Database!"
  type = string
  description = ""
}

variable "autonomous_database_license_model" {
  default = "LICENSE_INCLUDED"
  type = string
  description = "(Optional) (Updatable) The Oracle license model that applies to the Oracle Autonomous Database. Note that when provisioning an Autonomous Database on dedicated Exadata infrastructure, this attribute must be null because the attribute is already set at the Autonomous Exadata Infrastructure level. When using shared Exadata infrastructure, if a value is not specified, the system will supply the value of BRING_YOUR_OWN_LICENSE. It is a required field when db_workload is AJD and needs to be set to LICENSE_INCLUDED as AJD does not support default license_model value BRING_YOUR_OWN_LICENSE."
}

variable "autonomous_database_source" {
  default = "NONE"
  type = string
  description = <<EOF
  (Optional) The source of the database: Use NONE for creating a new Autonomous Database. Use DATABASE for creating a new Autonomous Database by cloning an existing Autonomous Database
For Autonomous Databases on shared Exadata infrastructure, the following cloning options are available: Use BACKUP_FROM_ID for creating a new Autonomous Database from a specified backup. Use BACKUP_FROM_TIMESTAMP for creating a point-in-time Autonomous Database clone using backups.
EOF
}

/*
variable "autonomous_database_clone_type" {
  default = "xxxx"
  type = string
  description = "(Required when source=BACKUP_FROM_ID | BACKUP_FROM_TIMESTAMP | DATABASE) The Autonomous Database clone type"
}


variable "autonomous_database_data_safe_status" {
  default = "xxxx"
  type = string
  description = "(Optional) (Updatable) Status of the Data Safe registration for this Autonomous Database. Could be REGISTERED or NOT_REGISTERED"
}
*/


/*
variable "autonomous_database_defined_tags" {
  default = "xxxx"
  type = string
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace."
}
*/


/*
variable "autonomous_database_is_auto_scaling_enabled" {
  default = "mydb149149"
  type = string
  description = "(Optional) (Updatable) Indicates if auto scaling is enabled for the Autonomous Database OCPU core count. The default value is FALSE"
}
*/

/*
variable "autonomous_database_is_data_guard_enabled" {
  default = "xxxx"
  type = string
  description = "(Optional) It is applicable only when is_data_guard_enabled is true. Could be set to PRIMARY or STANDBY. Default value is PRIMARY"
}
*/

/*
variable "autonomous_database_is_dedicated" {
  default = "xxxx"
  type = string
  description = "True if the database uses dedicated Exadata infrastructure."
}
*/

/*
variable "autonomous_database_is_preview_version_with_service_terms_accepted" {
  default = "mydb149149"
  type = string
  description = "(Optional) If set to TRUE, indicates that an Autonomous Database preview version is being provisioned, and that the preview version's terms of service have been accepted. Note that preview version software is only available for databases on shared Exadata infrastructure."
}
*/

/*
variable "autonomous_database_nsg_ids" {
  default = "xxxx"
  type = string
  description = "(Optional) (Updatable) A list of the OCIDs of the network security groups (NSGs) that this resource belongs to. Setting this to an empty array after the list is created removes the resource from all NSGs. For more information about NSGs, see Security Rules. NsgIds restrictions:
Autonomous Databases with private access require at least 1 Network Security Group (NSG). The nsgIds array cannot be empty.
"
}
*/

/*
variable "autonomous_database_private_endpoint_label" {
  default = "xxxx"
  type = string
  description = "(Optional) (Updatable) The private endpoint label for the resource."
}
*/

/*
variable "autonomous_database_refreshable_mode" {
  default = "xxxx"
  type = string
  description = "(Applicable when source=CLONE_TO_REFRESHABLE) (Updatable) The refresh mode of the clone. AUTOMATIC indicates that the clone is automatically being refreshed with data from the source Autonomous Database"
}
*/

/*
variable "autonomous_database_timestamp" {
  default = "xxxx"
  type = string
  description = "(Required when source=BACKUP_FROM_TIMESTAMP) The timestamp specified for the point-in-time clone of the source Autonomous Database. The timestamp must be in the past"
}
*/

/*
variable "autonomous_database_whitelisted_ips" {
  default = "xxxx"
  type = string
  description = "(Optional) (Updatable) The client IP access control list (ACL). This feature is available for databases on shared Exadata infrastructure only. Only clients connecting from an IP address included in the ACL may access the Autonomous Database instance. This is an array of CIDR (Classless Inter-Domain Routing) notations for a subnet or VCN OCID.
  Details see in https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/database_autonomous_database"
}
*/

