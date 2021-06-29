##CREACION DE GRUPO DE UBICACION PARA EL AUTO-SCALING GROUP, EL CUAL DEFINIMOS COMO CLUSTER##

resource "aws_placement_group" "PlacementGroupObligatorio" {
  name     = "PlacementGroupObligatorio"
  strategy = "cluster"
}


#AUTO-SCALING GROUP#

resource "aws_autoscaling_group" "ASGobligatorio" {
  name                      = "ASGobligatorio"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.LCobligatorio.name
  vpc_zone_identifier       = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id]

  timeouts {
    delete = "15m"
  }

}

#LAUNCH CONFIGURATION CONTENIENDO TEMPLATE DE INSTANCIAS EC2#

resource "aws_launch_configuration" "LCobligatorio" {
  name          = "LCobligatorioEC2"
  image_id      = var.ami_centos
  instance_type = "t2.micro"
  key_name = "key-pair-obl"
  security_groups = [aws_security_group.sg-public-obligatorio.id]
  user_data = "${file("/home/mauricio/Descargas/obligatoriofinal/Docker.sh")}"
  
   connection {
    type = "ssh"
    user = "centos"
    host_key = file("/root/Terraform/grupo3.pem")    
  }
  
}
#----------------------------------------------------------------------------------


#ATTACHMENT ENTRE AUTO-SCALING GROUP Y TARGET GROUP DE LOAD BALANCER#

resource "aws_autoscaling_attachment" "asg_attachment_Obl" {
  autoscaling_group_name = aws_autoscaling_group.ASGobligatorio.id
  alb_target_group_arn   = aws_alb_target_group.tg_obligatorio.arn
}

#----------------------------------------------------------------------------------

#LOAD BALANCER#

resource "aws_lb" "obligatorio_load_balancer" {
  name               = "obligatorioLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-public-obligatorio.id]
  subnets            = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id]

  tags = {
    Name = "obligatorio_load_balancer"
  }
}


#LOAD BALANCER LISTENER#

resource "aws_lb_listener" "balanceador_listener" {
  load_balancer_arn = aws_lb.obligatorio_load_balancer.id
  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg_obligatorio.id
  }
}

#LOAD BALANCER TARGET GROUP#

resource "aws_alb_target_group" "tg_obligatorio" {
  name     = "tgObligatorioV1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_obligatorio.id
}