# --- compute/ec2.tf ---
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.0.20230607.0-kernel-6.1-x86_64"]
  }
}

resource "random_id" "pc_node_id" {
  byte_length = 2
  count       = var.instance_count
}

resource "aws_key_pair" "pc_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
  }
resource "aws_instance" "pc_ec2_instance" {
  count         = var.instance_count # 1
  ami           = data.aws_ami.server_ami.id
  instance_type = var.instance_type # "t2.micro"

  tags = {
    Name = "HelloWorld_EC2_instance- ${random_id.pc_node_id[count.index].dec}"
  }
  key_name = aws_key_pair.pc_auth.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]
  # user_data = ""
  root_block_device {
    volume_size = var.volume_size
  }
}