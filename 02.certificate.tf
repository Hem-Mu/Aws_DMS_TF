resource "aws_dms_certificate" "cert" {
  certificate_id  = "dms-certificate123"
  #certificate_pem = var.pem_key
  certificate_wallet = filebase64("./rds-combined-ca-bundle.pem")

  tags = {
    Name = "test"
  }

}
output "cert_arn" {
     value = "${aws_dms_certificate.cert.certificate_arn}" # cert arn
   }
# 인증서가 없으면 DocumentDB에 접속 불가
## base64 암호화가 2번되는현상
/* resource "aws_dms_certificate" "certtest" {
certificate_id  = ""
  certificate_pem = ""
  certificate_wallet = ""
} */
