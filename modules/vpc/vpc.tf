
# VPC 
resource"aws_vpc""my_vpc"{

    cidr_block       = var.vpc_cidr
    instance_tenancy =  "default"
    



}

# Subnet



resource "aws_subnet""subnets"{

    count                   = length(var.subnet_cidr)  
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.subnet_cidr[count.index]
    availability_zone       = data.aws_availability_zones.available.names[count.index] 
    map_public_ip_on_launch = "true"

    tags = {
      "Name" = var.subnet_names[count.index] 
    }
}



# Internet Gateway


resource"aws_internet_gateway""int_gateway"{
   

   vpc_id = aws_vpc.my_vpc.id
   

}

# Route table

resource "aws_route_table" "rt_1" {

    vpc_id     = aws_vpc.my_vpc.id


    route {

     cidr_block  =  "0.0.0.0/0"
     gateway_id  = aws_internet_gateway.int_gateway.id
  
         }
}

# Route Table Association 


resource "aws_route_table_association" "rta_1" {

    count          =  length(var.subnet_cidr)   
    subnet_id      = aws_subnet.subnets[count.index].id
    route_table_id = aws_route_table.rt_1.id
  
}

