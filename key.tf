resource "aws_key_pair" "key" {
  key_name = "universalkey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
