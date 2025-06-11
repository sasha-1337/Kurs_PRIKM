output "jenkins_public_ip" {
  description = "Public IP address of Jenkins server"
  value       = aws_eip.jenkins_eip.public_ip
}

output "jenkins_web_url" {
  description = "Jenkins Web UI URL"
  value       = "http://${aws_eip.jenkins_eip.public_ip}:8181"
}

output "website_url" {
  description = "Deployed website URL"
  value       = "http://${aws_eip.jenkins_eip.public_ip}:8085"
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ${var.private_key_path} ubuntu@${aws_eip.jenkins_eip.public_ip}"
}