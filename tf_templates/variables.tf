variable "region" {
  default     = "us-east-1"
  description = "Region to be used for the deployment"
}

variable "db_secret_name" {
  default     = "db/tech_challenge_secret"
  description = "Name of the DB secret to be ceated."
}