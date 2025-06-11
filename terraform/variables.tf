variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_key_path" {
  description = "Path to your local .pub file"
  type        = string
}

variable "private_key_path" {
  description = "Path to your private key (for SSH/provisioning)"
  type        = string
}

variable "github_username" {
  description = "GitHub username"
  type        = string
}

variable "git_repo_url" {
  description = "Git repository URL for your website"
  type        = string
}

variable "github_token" {
  description = "GitHub access token"
  type        = string
  sensitive   = true
}

variable "dockerhub_username" {
  description = "DockerHub username"
  type        = string
}

variable "dockerhub_token" {
  description = "DockerHub access token"
  type        = string
  sensitive   = true
}