resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_server.id
  domain   = "vpc"

  tags = {
    Name = "jenkins-eip"
  }
}