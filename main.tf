terraform {

  backend "s3" {
    bucket = "terraform-state-bucket-travis"
    key    = "home/terraform-state"
    region = "us-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }


  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-1"
  assume_role {
    role_arn = "arn:aws:iam::774051255656:role/Developer"
  }
}

resource "aws_instance" "app_server" {
  ami                         = "ami-05af0694d2e8e6df3"
  instance_type               = "t2.micro"
  key_name                    = "Travis_ansible_key"
  associate_public_ip_address = "true"
  subnet_id                   = "subnet-8e073cd5"
  security_groups             = ["sg-034572ff6fa08b725"]

  provisioner "remote-exec" {
    inline = ["sudo yum update -y", "echo Done!"]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.pvt_key)
    }
  }

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${var.pvt_key} EC2_runner_playbook.yml"
  }

  tags = {
    Name = var.instance_name
  }
}
