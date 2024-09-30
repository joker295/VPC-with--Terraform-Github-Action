variable "sg_id" {

    description = "SG for ALB"
     type       =  string 
}


variable"vpc_id"{

    description = "VPC for ALB"
    type        =  string

}


variable "instances" {
     
     description = "Instance ID for Target group Attachment "
     type        =  list(string)

}


variable "subnets" {
     description = "Subnets for ALB"
     type        =  list(string)

}