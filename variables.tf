variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "dbname" {
  description = "instance name for DB Server"
  type        = string
  default     = ""
}

variable "name" {
  description = "instance name for DB Server"
  type        = string
  default     = ""
}

variable "multi_availability_zone" {
  default     = false
  type        = bool
  description = "Flag to enable hot standby in another availability zone"
}

variable "DB_instance_ami" {
  description = "ID of the AMI used for DB server"
  type        = string
  default     = ""
}

variable "DB_security_group_ids" {
  type        = string
  default     = ""
  description = "A list of security group IDs to associate with DB servers."
}

variable "DB_instance_type" {
  description = "Type of the instance for DB"
  type        = string
  default     = ""
}

# variable "aws_region_az" {
#   description = "AWS region availability zone"
#   type        = string
#   default     = ""
# }


variable "subnet_id_forDB1" {
  description = "Enter the subnet ID to use for second DB server"
  type        = list(string)
  default     = ["", "", "", ""]
}

variable "DB_iam_role"{
    description = "Enter your IAM role for DB server"
    type        = string
    default     = "EFS-IAM-full-access"
}


variable "DBVER" {
  type        = string
  default     = "13.7"

}

variable "availability_zones" {
  description = "A list of one or more availability zones for the group. Used for EC2-Classic and default subnets when not specified with `vpc_zone_identifier` argument. Conflicts with `vpc_zone_identifier`"
  type        = list(string)
  default     = [""]
}


variable "family" {
  description = "The family of the parameter group"
  default = "postgres13"
}

variable "parameter" {
  description = "List containing map of parameters to apply"
  type        = list(map(any))
  default     =[
    {
      name  = "random_page_cost"
      value = 1.1
    },
    {
      name  = "plan_cache_mode"
      value = "force_custom_plan"
      
    },
    { 
     name  = "work_mem"
     value = 30000
      
    },
    {
      name  = "wal_writer_delay"
      value = 200
      
    },
    {
      name  = "wal_buffers"
      value = 8192
      
    },
    {
      name = "cron.database_name"
      value = ""
    },
    {
      name  = "timezone"
      value = "US/Eastern"
      
    },
    {
      name  = "shared_preload_libraries"
      value = "auto_explain,pg_cron"
      
    },
    {
      name  = "min_wal_size"
      value = 1024
      
    },
    {
      name  = "max_wal_size"
      value = 8092
      
    },
    {
      name  = "max_connections"
      value = 300
      
    },
    {
      name  = "log_statement"
      value = "ddl"
      
    },
    {
      name  = "maintenance_work_mem"
      value = 2097152
      
    },
    {
      name  = "log_rotation_age"
      value = 240
      
    },
    {
      name  = "log_min_duration_statement"
      value = 250000 
      
    },
    {
      name  = "log_lock_waits"
      value = 1
      
    },
    {
      name  = "shared_buffers"
      value = 1048625
      
    },
    {
      name  = "effective_cache_size"
      value = 2883584
      
    },
    {
      name  = "checkpoint_timeout"
      value = 600
      
    },
    {
      name  = "huge_pages"
      value =  "off"
    }
  
  ]
}




variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "Environment" {
  description = "instance name for DB Server"
  type        = string
  default     = "lower"
}

variable "Name" {
  description = "instance name for DB Server"
  type        = string
  default     = ""
}

variable "program" {
  description = "instance name for DB Server"
  type        = string
  default     = ""
}

variable "project" {
  description = "instance name for DB Server"
  type        = string
  default     = ""
}

variable "group" {
  description = "instance name "
  type        = string
  default     = "terraform"
}

variable "replica" {
  description = "instance name "
  type        = string
  default     = "-replica "
}
