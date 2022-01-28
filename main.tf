output "controller_ip" {
  value = aws_instance.controller_instance.private_ip
}
output "hub_ip" {
  value = aws_instance.hub_instance.private_ip
}
output "execnode_ip" {
  value = aws_instance.exec_instance.private_ip
}
