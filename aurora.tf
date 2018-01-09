
resource "aws_db_subnet_group" "prod_aurora_subnet" {

    name          = "aurora_db_subnet_group"
    description   = "Allowed subnets for Aurora DB cluster instances"
    subnet_ids    = [
        "${aws_subnet.prod_private_1.id}",
        "${aws_subnet.prod_private_2.id}"
    ]

    tags {
        Name         = "Aurora-DB-Subnet-Group"
    }

}

resource "aws_rds_cluster" "aurora_cluster" {

    cluster_identifier            = "aurora-cluster"
    database_name                 = "${var.RDS_DB_NAME}"
    master_username               = "${var.RDS_USERNAME}"
    master_password               = "${var.RDS_PASSWORD}"
    backup_retention_period       = 7
    preferred_backup_window       = "04:00-05:00"
    preferred_maintenance_window  = "wed:03:00-wed:04:00"
    db_subnet_group_name          = "${aws_db_subnet_group.prod_aurora_subnet.name}"
    final_snapshot_identifier     = "aurora-cluster"
    availability_zones            = ["${aws_subnet.prod_private_1.availability_zone}","${aws_subnet.prod_private_2.availability_zone}"]   # prefered AZ
    vpc_security_group_ids        = [
            "${aws_security_group.sg_auroradb.id}"
    ]

    tags {
        Name         = "Aurora-DB-Cluster"
    }

    lifecycle {
        ignore_changes = "*"
    }

}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {

    identifier            = "aurora-instance"
    cluster_identifier    = "${aws_rds_cluster.aurora_cluster.id}"
    instance_class        = "${var.DB_MACHINE_TYPE}"
    db_subnet_group_name  = "${aws_db_subnet_group.prod_aurora_subnet.name}"
    publicly_accessible   = false
    
    tags {
        Name         = "Aurora-DB-Instance"
    }

    lifecycle {
        create_before_destroy = true
    }

}


