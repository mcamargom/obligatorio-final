
#SUBNET GROUP PARA LA BASE DE DATOS#
#OBLIGATORIAMENTE SE DEBEN INCLUIR DOS SUBNETS DISTINTAS# 

resource "aws_db_subnet_group" "subnet_db_obl" {
 name       = "subnet_db_obl"
 subnet_ids = [aws_subnet.subnet_internal1.id, aws_subnet.subnet_internal2.id]
 tags = {
   Name = "Subnet para RDS Obligatorio "
 }
}

#CREACION DE LA INSTANCIA DE BASE DE DATOS#

resource "aws_db_instance" "rdsObligatorio" {
  identifier = "rdsobligatorio"
  allocated_storage    = 10
  max_allocated_storage    = 15
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "rdsDbObl"
  username             = "admin"
  password             = "adminadmin"
  maintenance_window   = "Fri:03:00-Fri:03:30"
  backup_window        = "05:00-06:00"
  backup_retention_period = 0
  
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.subnet_db_obl.id


  tags = {
  Name = "RDS_DB_Obl"
}
}

#SNAPSHOTS PARA BACKUP#

resource "aws_db_snapshot" "BackupRDS" {
  db_instance_identifier = aws_db_instance.rdsObligatorio.id
  db_snapshot_identifier = "BackupRDS1"
}

#LOS PARAMETROS DEFINIDOS ANTERIORMENTE SON PROPIOS DE UNA CONFIGURACION DE TEST#
#AWS EDUCATE NO PERMITE CREAR INSTANCIAS DE MAYOR TAMAÑO#
#FREE TIER - T2.MICRO - STORAGE 
