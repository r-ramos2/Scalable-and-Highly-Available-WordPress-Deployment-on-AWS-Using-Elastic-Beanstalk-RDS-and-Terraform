variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

