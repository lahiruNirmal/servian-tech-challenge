# Used to encrypt DB
resource "aws_kms_key" "db-encryption-key" {
  description             = "DB encryption key"
  deletion_window_in_days = 10

  tags = {
    "Name" = "db-encryption-key"
  }
}