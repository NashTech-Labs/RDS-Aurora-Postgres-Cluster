variable "vpc_id" {}
variable "cidr" {}

variable "public-subnet-1" {}
variable "public-subnet-2" {}

variable "db-username" {}
variable "db-password" {}
variable "env" {}

variable "postgres-engine-version" {
	default = "11.13"
	type = string
}

variable "db-name" {}