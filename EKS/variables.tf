variable project { type = string }

variable env { type = string }

variable cluster_version { type = string }

variable subnet_ids { type = list(string) }

variable endpoint_private_access { type = bool }

variable endpoint_public_access { type = bool }

variable eks_cluster_security_group_ids { type = list(string) }

variable node_instance_types { type = list(string) }

variable node_capacity_type { type = string }

variable node_disk_size { 
  type = number 
  default = 8
}
