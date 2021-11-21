resource "aws_kms_key" "week12-kms" {
  description             = "Week_7 KMS Key"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "week12-kms" {
  name          = "alias/week12-kms"
  target_key_id = aws_kms_key.week12-kms.key_id
}
