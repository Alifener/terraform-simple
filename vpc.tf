# Internet VPC
resource "aws_vpc" "prod" {
    cidr_block = "10.1.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"

}

# Subnets
resource "aws_subnet" "prod_public_1" {
    vpc_id = "${aws_vpc.prod.id}"
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.AWS_REGION}a"

    tags {
        Name = "public_1"
    }
}

# Subnets
resource "aws_subnet" "prod_public_2" {
    vpc_id = "${aws_vpc.prod.id}"
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.AWS_REGION}b"

    tags {
        Name = "public_2"
    }
}

resource "aws_subnet" "prod_private_1" {
    vpc_id = "${aws_vpc.prod.id}"
    cidr_block = "10.1.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.AWS_REGION}a"

    tags {
        Name = "private_1"
    }
}

resource "aws_subnet" "prod_private_2" {
    vpc_id = "${aws_vpc.prod.id}"
    cidr_block = "10.1.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.AWS_REGION}b"

    tags {
        Name = "private_2"
    }
}

# Internet GW
resource "aws_internet_gateway" "prod_gw" {
    vpc_id = "${aws_vpc.prod.id}"
}

# route tables
resource "aws_route_table" "prod_public" {
    vpc_id = "${aws_vpc.prod.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.prod_gw.id}"
    }

    tags {
        Name = "public"
    }
}

# route associations public
resource "aws_route_table_association" "prod_public_1_a" {
    subnet_id = "${aws_subnet.prod_public_1.id}"
    route_table_id = "${aws_route_table.prod_public.id}"
}

# route associations public
resource "aws_route_table_association" "prod_public_2_b" {
    subnet_id = "${aws_subnet.prod_public_2.id}"
    route_table_id = "${aws_route_table.prod_public.id}"
}
