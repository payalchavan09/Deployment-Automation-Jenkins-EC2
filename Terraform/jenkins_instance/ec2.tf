# --- compute/ec2.tf ---
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"]
  }
}

resource "random_id" "pc_node_id" {
  byte_length = 2
  count       = var.instance_count
}

resource "aws_key_pair" "jenkins_auth" {
  key_name   = var.key_name
  public_key = file(var.jen_key_path)
}
resource "aws_instance" "jenkins_ec2_instance" {
  count         = var.instance_count # 1
  ami           = data.aws_ami.server_ami.id
  instance_type = var.instance_type # "t2.micro"

  tags = {
    Name = "Jenkins_EC2_instance-${random_id.pc_node_id[count.index].dec}"
  }
  key_name               = aws_key_pair.jenkins_auth.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]
  # Deploy Jenkins using script
  #Bootstrap the instance with a script that will install and start Jenkins

  user_data = file("installjenkins.sh")
  root_block_device {
    volume_size = var.volume_size
  }
}

resource "aws_eip" "jenkins_eip" {
  count = var.instance_count
  # Attaching it to the jenkins_server EC2 instance
  instance = aws_instance.jenkins_ec2_instance.*.id[count.index]

  # Making sure it is inside the VPC
  domain = "vpc"

  # Setting the tag Name to jenkins_eip
  tags = {
    Name = "jenkins_eip"
  }
}