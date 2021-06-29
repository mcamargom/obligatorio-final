
#SE DEFINE EL RECURSO S3#

resource "aws_s3_bucket" "bucket-s3-obligatorio" {
  bucket = "bucket-s3-obligatorio"
  acl    = "private"
  
  
  #REGLA PARA DEFINIR LA ACTIVACION DEL CICLO DE VIDA# 
  #PASADO EL TIEMPO DE TRANSICION DE 60 DIAS SE ACTIVA EL ALMACENAMIENTO CON GLACIER#
  
  lifecycle_rule {
    enabled = true
    
    transition {
    days = 60
    storage_class = "GLACIER"
  }

  } 
  
  #SENTENCIA QUE DECLARA LA ACTIVACION DEL VERSIONADO#

  versioning {
    enabled = true
  }

  tags = {
    Name = "First-Bucket-obligatorio"

  }
}

