provider "aws" {
  region = var.aws_region
}


resource "aws_db_instance" "source_db" {
  identifier              = var.dbname
  db_name                 = var.name
  engine                  = "postgres"
  engine_version          = "13.7"
  port                    = "5432"
  username                = "postgres"
  password                = "u5acDbapr22"
  instance_class          = "db.m5.2xlarge"
  allocated_storage       = 200
  max_allocated_storage   = 1000
  skip_final_snapshot     = true
  db_subnet_group_name    = "subnetgroup"
  vpc_security_group_ids  = [""]
  publicly_accessible     = false
  iops                    = 3000
 
  enabled_cloudwatch_logs_exports = ["postgresql"]

  iam_database_authentication_enabled = true

  storage_encrypted = true

  multi_az = true
  #replicate_source_db = aws_db_instance.cgr-prd-pg-usac-org.id
  parameter_group_name = aws_db_parameter_group.parametergroup.name
 

  backup_retention_period  = 1

   tags = {
    Environment =  var.Environment
    Name        =  var.Name
    program     =  var.program
    project     =  var.project
  }


  # Database Deletion Protection
  deletion_protection = true
   
  }

  resource "aws_db_instance" "replicate_source_db" {
  identifier               =  "-replica"
  #db_name                 =  var.name
  #engine                  =  "postgres-replica"
  #engine_version          =  "13.6-replica"
  port                     =  "5432"
  #username                =  "postgres-replica"
  #password                 =  "placeholderpassword"
  instance_class           =  "db.m5.2xlarge"
  allocated_storage        =  200
  max_allocated_storage    =  1000
  skip_final_snapshot      =  true
  #db_subnet_group_name     =  ""
  #vpc_security_group_ids   =  [var.DB_security_group_ids]
  publicly_accessible      =  false
  iops                     =  3000
 
  enabled_cloudwatch_logs_exports = ["postgresql"]

  iam_database_authentication_enabled = true

  storage_encrypted = true

  multi_az = true
  replicate_source_db = aws_db_instance.cgr-prd-pg-1b-usac-org.id
  parameter_group_name = aws_db_parameter_group.parametergroup.name
 

  #backup_retention_period  = 1

   tags = {
    Environment =  "${var.Environment}-replica"
    Name        =  "${var.Name}-replica"
    program     =  "${var.program}-replica"
    project     =  "${var.project}-replica"
  }


  # Database Deletion Protection
  deletion_protection = true
   
  }

 resource "aws_db_parameter_group" "parametergroup" {
  name        = var.group
  description = "${var.group} parametergroup"
  family      = var.family
  dynamic "parameter" {
    for_each = var.parameter
    content {
      apply_method = lookup(parameter.value, "apply_method", "pending-reboot")
      name         = parameter.value["name"]
      value        = parameter.value["value"]
    }
  }
  tags = merge({ "Name" = var.name }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}
