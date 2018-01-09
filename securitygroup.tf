resource "aws_security_group" "sg_prod_fronttier" {
  vpc_id = "${aws_vpc.prod.id}"
  name = "sg_fronttier"
  description = "security group that allows ssh,http and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  
tags {
    Name = "sg-fronttier"
  }
}

resource "aws_security_group" "sg_auroradb" {
  vpc_id = "${aws_vpc.prod.id}"
  name = "sg_auroradb"
  description = "allow to auroradb"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.sg_prod_fronttier.id}"]      
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }
  tags {
    Name = "sg-auroradb"
  }
}
