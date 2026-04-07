variable project { type = string }

variable env { type = string }

variable cluster_version { type = string }

variable subnet_ids { type = list(string) }

variable endpoint_private_access { type = bool }

variable endpoint_public_access { type = bool }

variable eks_cluster_security_group_ids { type = list(string) }

variable node_instance_types { type = list(string) }

variable node_capacity_type { type = string }

variable "node_disk_size" {
  type        = number
  description = "Disk size (in GB) for EKS worker nodes"
  default     = 8

  validation {
    condition     = var.node_disk_size >= 10 && var.node_disk_size <= 1000
    error_message = "Disk size must be between 8GB and 25GB."
  }
}

