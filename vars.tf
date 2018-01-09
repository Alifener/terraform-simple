
variable "FRONTTIER_MACHINE_COUNT" {
	description = "Machine count of fronttier ASG "
	default=1
}

variable "FRONTTIER_MACHINE_COUNT_MAX" {
	description = "Maximum machine count of fronttier ASG"
	default=1
}

variable "DB_CLUSTER_MACHINE_COUNT" {
	description = "Aurora RDS cluster machine count"
	default     = 1
}

variable "FRONTTIER__MACHINE_TYPE" {
	description ="The EC2 instance machine types which will be used in front tier"
	default     = "t2.micro"
}

variable "DB_MACHINE_TYPE" {
	description = "Aurora db database machine types"
	default     = "db.t2.small"
}

variable "AWS_REGION" {
  description = "The AWS regions name which machine will be installed in"
  default = "eu-west-2"
}

variable "AMIS" {
	type="map"
	default = {
		eu-west-2 = "ami-e7d6c983",
		eu-west-1 = "ami-1a962263"
	}
}

variable "RDS_DB_NAME" {
	description = "Aurora RDS database name"
	default = "universal"
}

variable "RDS_USERNAME" {
	description = "Aurora RDS database username"
	default 	= "root"
}

variable "RDS_PASSWORD" { 
	description = "Aurora RDS database root password"
	default = "universal123"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "../keys/universalkey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../keys/universalkey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}



