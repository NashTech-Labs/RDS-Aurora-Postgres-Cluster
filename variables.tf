variable "region" {
  default     = "ap-south-1"
  type        = string
  description = "AWS region to which the infrastructure need to deploy"
}

variable "access_key" {
  type        = string
  description = "AWS IAM ACCESS_KEY"
}
variable "secret_key" {
  type        = string
  description = "AWS IAM SECRET_KEY"
}
variable "cluster_name" {
  default     = "rds-cluster"
  type        = string
  description = "Name of the rds cluster"
}

variable "env" {
  default     = "rds-aurora"
  type        = string
  description = "Environment for the rds cluster"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}
