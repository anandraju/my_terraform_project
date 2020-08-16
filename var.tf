variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-2 = "ami-07c8bc5c1ce9598c3"
    us-east-2 = "ami-02b0c55eeae6d5096"

  }
}

variable "nat_amis" {
  type = map(string)
  default = {
    us-east-2 = "ami-0bbe28eb2173f6167"
    us-east-2 = "ami-06817f01dcc7f30be"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "web_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "web_amis" {
  type = map(string)
  default = {
    us-east-2 = "ami-07c8bc5c1ce9598c3"
    us-east-2 = "ami-02b0c55eeae6d5096"
  }
}
variable "web_ec2_count" {
  type    = string
  default = "2"
}

variable "web_tags" {
  type = map(string)
  default = {
    Name = "Webserver"
  }
}
