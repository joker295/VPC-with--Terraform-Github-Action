resource "aws_lb" "internet_facing" {

     name               = "Internet-facing-ALB" 
     load_balancer_type = "application" 
     security_groups    = [var.sg_id]
     subnets            =  var.subnets
     internal           =  false

     enable_deletion_protection = false

  
}


# Listner 

resource "aws_lb_listener" "listner_1" {
 
  load_balancer_arn = aws_lb.internet_facing.id
  port              =  "80" 
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_1.id
  }
}

# Target Group


resource "aws_lb_target_group" "tg_1" {
 
 
  name     = "tg-ALB"
  port     =   80
  protocol =  "HTTP"
  vpc_id   = var.vpc_id
}

# Target Group attachment 

resource "aws_lb_target_group_attachment" "tga" {

     count            = length(var.instances)
     target_group_arn = aws_lb_target_group.tg_1.arn
     target_id        = var.instances[count.index]
     port             = 80
}


