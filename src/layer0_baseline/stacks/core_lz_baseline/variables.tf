# ======================================================================
#  Created by: Dr. Rigoberto Garcia 11/01/2025
#  description: Variables for Layer 0 Baseline core stack
#  notes: This file defines the input variables
# ======================================================================

variable "tenancy_ocid" {
  description = "OCID of the parent tenancy (allegisgroup)"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaawhowwgqzjjqhmnhkjumnmlegqfcock3v2f64scsembcnuz32iq"
}

variable "child_tenancy_ocid" {
  description = "OCID of the child tenancy (tgsv1)"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaelre24qykkdaengpbb2jcmfahlyg2zu32ywgtu2wbpo3fzf25cq"
}

variable "user_ocid" {
  description = "OCID of your IAM user"
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaafesuqya4bxszsohfndhw75ufcyuwor6bcaa7ogyahzjty24sq73a"
}

variable "fingerprint" {
  description = "API key fingerprint"
  type        = string
  default     = "23:90:2b:2b:27:ab:da:51:eb:79:e7:ba:85:7f:2b:6d"
}

variable "private_key_path" {
  description = "Path to your OCI API private key"
  type        = string
  default     = "C:\\Users\\Administrator\\.oci\\oci_api_key.pem"
}
variable "tenancy_ocid" {
  description = "OCID of the parent tenancy (allegisgroup)"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaawhowwgqzjjqhmnhkjumnmlegqfcock3v2f64scsembcnuz32iq"
}

variable "child_tenancy_ocid" {
  description = "OCID of the child tenancy (tgsv1)"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaelre24qykkdaengpbb2jcmfahlyg2zu32ywgtu2wbpo3fzf25cq"
}

variable "user_ocid" {
  description = "OCID of the IAM user"
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaafesuqya4bxszsohfndhw75ufcyuwor6bcaa7ogyahzjty24sq73a"
}

variable "fingerprint" {
  description = "Fingerprint of the uploaded API key"
  type        = string
  default     = "23:90:2b:2b:27:ab:da:51:eb:79:e7:ba:85:7f:2b:6d"
}

variable "private_key_path" {
  description = "Path to your OCI API private key"
  type        = string
  default     = "C:\\Users\\Administrator\\.oci\\oci_api_key.pem"
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "us-ashburn-1"
}
