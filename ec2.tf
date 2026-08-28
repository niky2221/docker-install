resource "aws_instance" "docker" {
  ami           = data.aws_ami.expense.id
  vpc_security_group_ids = [aws_security_group.allow-tls.id]
  instance_type = "t3.micro"

  connection {
    host     = aws_instance.docker.public_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "docker.sh"
    destination = "/tmp/docker.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/docker.sh",
      "sudo sh /tmp/docker.sh"
    ]
  }
  tags = {
    Name = "Docker"
  }
}
resource "aws_security_group" "allow-tls" {
    name        = "allow-tls"
    description = "allow tls inbound and outbound rules"

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }


  tags = {
    Name = "allow-tls"
  }

}


output "public_ip" {
  value = aws_instance.docker.public_ip

}