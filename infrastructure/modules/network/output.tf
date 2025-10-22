output "public_subnet" {
  value = aws_subnet.public_subnet[*]
}
output "private_subnets" {
  value = aws_subnet.private_subnet[*]
}
