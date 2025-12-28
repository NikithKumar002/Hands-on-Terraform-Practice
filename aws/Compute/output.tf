# output "NetworkModuleOutput" {
#   value = data.terraform_remote_state.Networking
# }

output "aws_webserver_id" {
  value = aws_instance.web_server[*].id
}

output "ec2_public_ip" {
  value = aws_instance.web_server[*].public_ip
}

output "ec2_public_dns" {
  value = aws_instance.web_server[*].public_dns
}

