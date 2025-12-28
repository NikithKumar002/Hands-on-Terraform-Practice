data "aws_ami" "ubuntu" {
  most_recent = true
  # Canonical Account ID for Ubuntu
  owners      = ["099720109477"] 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "terraform_remote_state" "Networking" {
  backend = "local"
  config = {
    path = "../Networking/terraform.tfstate"
  }
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform_key"
  public_key = file("~/.ssh/terraform_aws_ec2_key_pair.pub")
  tags = merge(var.tags, { Name = "terraform_key" })
}

resource "aws_security_group" "web_sg" {
  name        = "WebInstance-SG"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.Networking.outputs.aws_vpc_test.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "WebInstance-SG" })
}

resource "aws_instance" "web_server" {
  count                  = var.instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.terraform_remote_state.Networking.outputs.aws_subnet_public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.terraform_key.key_name
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [
        "sudo apt update -y",
        "sudo apt install -y apache2",
        "sudo systemctl start apache2"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/terraform_aws_ec2_key_pair")
      host        = self.public_ip
    }
  }

  tags = merge({ name = "WebServerInstance-${count.index}" }, var.tags)
}
