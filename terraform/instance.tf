# EC2 Instance
resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = base64gzip(templatefile("${path.module}/user_data.sh", {
    github_username    = var.github_username
    git_repo_url       = var.git_repo_url
    github_token       = var.github_token
    dockerhub_username = var.dockerhub_username
    dockerhub_token    = var.dockerhub_token
  }))

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  tags = {
    Name = "jenkins-server"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = file(var.public_key_path)
}
