resource "aws_secretsmanager_secret" "db-secret" {
  name = "db/tech_challenge_secret"
  description = "Secret for username and password for DB"
}

resource "aws_secretsmanager_secret_version" "db-secret-version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode(var.db_secret)
}