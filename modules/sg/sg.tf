data "http" "my_ip" {
  url = "https://ipinfo.io/ip"
}



resource "aws_security_group" "sg" {

   name        =  "sg"
   description =  "Allows HTTP,SSH inbound traffic"
   vpc_id      =   var.vpc_id

   ingress {
     
      description   =  "Allows HTTPS Access "
      from_port     =   80
      to_port       =   80 
      protocol      =   "tcp"
      cidr_blocks    =   ["0.0.0.0/0"]
      

   }
   
   ingress {
     
      description   =  "Allows SSH Access"
      from_port     =   22
      to_port       =   22
      protocol      =   "tcp"
      cidr_blocks    =  ["${trimspace(data.http.my_ip.response_body)}/32"]
      

   }

   tags= {
      
       name= "Security-group"

   }



}



# resource "aws_network_acl" "name" {
#   vpc_id = 
# }