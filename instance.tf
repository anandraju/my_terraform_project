locals {
env_tag = {
    Environment = terraform.workspace
}

web_tags = merge(var.web_tags, local.env_tag)
}

resource "aws_instance" "web" {
  count         = var.web_ec2_count
  ami           = var.web_amis[var.AWS_REGION]
  instance_type = var.web_instance_type
  subnet_id     = aws_subnet.public.*.id[count.index]
  tags          = local.web_tags
  user_data = file("scripts/install_apache.sh")
}
