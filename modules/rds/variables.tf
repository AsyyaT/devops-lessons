variable "name" {
  description = "Short name for DB resources (prefix)"
  type        = string
  default     = "appdb"
}

variable "use_aurora" {
  description = "Якщо true — створюємо Aurora cluster, інакше — одиничний aws_db_instance"
  type        = bool
  default     = false
}

variable "engine" {
  description = "DB engine (postgres, mysql, aurora-postgresql, aurora-mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Версія движка"
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "EC2 instance class для RDS instance (db.*)"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Розмір диску (GB) для одиночної RDS (ігнорується для Aurora)"
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Якщо true — створюємо multi-AZ одиночну RDS instance"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Назва БД (initial database)"
  type        = string
  default     = "app"
}

variable "username" {
  description = "DB admin username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "DB admin password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC id для security group"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Список приватних subnet ids для DB subnet group (мінімум 2 для production)"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "CIDR-мережі, яким дозволено підключення до БД (через security group). Порожній список — закрито."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map tag-ів, додаткові теги"
  type        = map(string)
  default     = {}
}

variable "db_parameters" {
  description = "Додаткові параметри для parameter group; формат: list(object({ name=string, value=string, apply_method=string }))"
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  default = []
}

variable "engine_cluster" {
  type    = string
  default = "aurora-postgresql"
}
variable "aurora_replica_count" {
  type    = number
  default = 1
}

variable "aurora_instance_count" {
  type    = number
  default = 2 # 1 primary + 1 replica
}

variable "subnet_private_ids" {
  type = list(string)
}

variable "subnet_public_ids" {
  type = list(string)
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "parameters" {
  type    = map(string)
  default = {}
}

variable "backup_retention_period" {
  type    = string
  default = ""
}

variable "parameter_group_family_aurora" {
  type    = string
  default = "aurora-postgresql15"
}
variable "engine_version_cluster" {
  type    = string
  default = "15.3"
}
variable "parameter_group_family_rds" {
  type    = string
  default = "postgres15"
}
