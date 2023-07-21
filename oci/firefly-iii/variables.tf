variable "compartment_ocid" {
  description = "The OCID of the compartment where the resources will be created."
}

variable "tenancy_ocid" {
  description = "The OCID of the tenancy where the resources will be created."
}

variable "instance_shape" {
  description = "The shape of the Oracle VM instance."
  default     = "VM.Standard.A1.Flex"
}
