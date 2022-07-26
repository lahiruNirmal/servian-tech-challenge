data "aws_ami" "ec2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] 
}

resource "aws_launch_configuration" "as_config" {
  name_prefix   = "tech-challenge-app-server-"
  image_id      = data.aws_ami.ec2_ami.id
  instance_type = "t2.micro"
  security_groups = ["application-sg"]

  lifecycle {
    create_before_destroy = true
  }

  user_data = "${file("${path.module}/userdata/userdata.sh")}"
}
