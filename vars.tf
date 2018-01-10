
variable "fronttier_machine_count" {
	description = "Machine count of fronttier ASG "
	default=1
}

variable "asg_max_count" {
	description = "Max Number of ASG Instances"
	default=1
}

variable "db_cluster_instance_count" {
	description = "Number of Aurora RDS cluster instances"
	default     = 1
}

variable "public_subnet_instance_type" {
	description ="Frontend EC2 instance type"
	default     = "t2.micro"
}

variable "db_instance_type" {
	description = "Aurora db database instance types"
	default     = "db.t2.small"
}

variable "aws_region" {
  description = "The AWS regions name which machine will be installed in"
  default = "eu-west-2"
}

variable "amis" {
	type="map"
	default = {
		eu-west-2 = "ami-e7d6c983",
		eu-west-1 = "ami-1a962263"
	}
}

variable "rds_db_name" {
	description = "Aurora RDS database name"
	default = "universal"
}

variable "rds_username" {
	description = "Aurora RDS database username"
	default 	= "root"
}

variable "rds_password" { 
	description = "Aurora RDS database root password"
	default = "universal123"
}

variable "path_to_private_key" {
  default = "../keys/universalkey"
}

variable "path_to_public_key" {
  default = "../keys/universalkey.pub"
}

variable "instance_username" {
  default = "ec2-user"
}



