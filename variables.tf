variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

