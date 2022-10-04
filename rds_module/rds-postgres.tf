resource "aws_security_group" "rds" {
  name   = "${var.db-name}-postgres-db-security-group"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = [var.cidr]
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [ingress]
  }

  tags = {
    Name        = "${var.db-name}-postgres-db-security-group"
    Environment = var.env
  }

}

resource "aws_db_subnet_group" "rds-subnet" {
  name       = "${var.db-name}-postgres-db-subnet"
  subnet_ids = [var.public-subnet-1]

  tags = {
    Name        = "${var.db-name}-postgres-db-subnet"
    Environment = var.env
  }
}

resource "aws_rds_cluster_instance" "postgres" {
  identifier                      = "${var.db-name}-aurora-postgres-db"
  cluster_identifier              = aws_rds_cluster.postgres.id
  instance_class                  = "db.t3.medium"
  engine                          = aws_rds_cluster.postgres.engine
  engine_version                  = var.postgres-engine-version
  copy_tags_to_snapshot           = true
  publicly_accessible             = true
  promotion_tier                  = 0

  tags = {
    "Name"        = aws_rds_cluster.postgres.cluster_identifier
    "version"     = var.postgres-engine-version
    "Environment" = var.env
    "terraform"   = "true"
  }
}

resource "aws_rds_cluster" "postgres" {
  cluster_identifier              = "${var.db-name}-aurora-postgres-db-cluster"
  engine                          = "aurora-postgresql"
  engine_version                  = var.postgres-engine-version
  database_name                   = var.db-name
  master_username                 = var.db-username
  master_password                 = var.db-password
  db_subnet_group_name            = aws_db_subnet_group.rds-subnet.name
  vpc_security_group_ids          = [aws_security_group.rds.id]
  port                            = 5432
  availability_zones              = [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1]]
  skip_final_snapshot             = true
  apply_immediately               = true
  backup_retention_period         = 1
  preferred_backup_window         = "00:00-02:00"
  preferred_maintenance_window    = "wed:02:00-wed:04:00"
  copy_tags_to_snapshot           = true
  deletion_protection             = false
  
  tags = {
    "Name"        = "${var.db-name}-aurora-postgres-db-cluster"
    "version"     = var.postgres-engine-version
    "Environment" = var.env
    "terraform"   = "true"    
  }
}
