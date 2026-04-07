variable project { type = string }

variable env { type = string }

variable cluster_version { type = string }

variable subnet_ids { type = list(string) }

variable endpoint_private_access { type = bool }

variable endpoint_public_access { type = bool }

variable eks_cluster_security_group_ids { type = list(string) }
