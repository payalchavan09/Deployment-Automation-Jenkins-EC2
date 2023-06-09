output "vpc_id" {
  value = aws_vpc.pc_vpc.id
}

output "public_sg" {
  value = aws_security_group.pc_sg["public"].id
}

output "public_subnets" {
  value = aws_subnet.pc_public_subnet.*.id
}
