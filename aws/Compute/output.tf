# output "NetworkModuleOutput" {
#   value = data.terraform_remote_state.Networking
# }
output "ec2_public_ip" {
  value = aws_instance.web_server[*].public_ip
}

output "ec2_public_dns" {
  value = aws_instance.web_server[*].public_dns
}

