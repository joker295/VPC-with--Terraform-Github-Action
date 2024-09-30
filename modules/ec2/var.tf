variable "sg_id" {

    description = "SG for ec2 instances "
    type       =  string

  
}


variable "subnets" {

    description = "subnets for EC2"
     type       =  list(string) 

  
}

variable "ec2_names" {

    default     = ["Instance A","Instance B" ]
    description = "names for EC2"
    type        =  list(string) 
     

  
}