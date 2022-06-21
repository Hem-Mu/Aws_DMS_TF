resource "aws_dms_endpoint" "target" {
  # certificate_arn             = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  database_name               = "target" # 생성될 DB 이름

  endpoint_id                 = "source-to-target-endpoint-tf" # identifier
  endpoint_type               = "target"
  engine_name                 = "docdb"
  extra_connection_attributes = "" # 추가 연결 속성 https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.PostgreSQL.html#CHAP_Source.PostgreSQL.ConnectionAttrib
  # kms_key_arn                 = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # kms키를 사용하지 않으면 default key사용

  username                    = "hamster" # DB USER
  password                    = "hamster1" # DB USER PW
  port                        = 27017
  server_name                 = data.terraform_remote_state.docdb.outputs.cluster_add # local private IP ##
  ssl_mode                    = "verify-full"
  certificate_arn             = "arn:aws:dms:ap-northeast-2:765606275717:cert:IVTI52ZYXOJ5RDO3B6H4FJYFLPUF5YNDUKUPH2A" # aws_dms_certificate.cert.certificate_arn

  tags = {
    Name = "test"
  }
}
output "target_arn" {
     value = "${aws_dms_endpoint.target.endpoint_arn}" # cert arn
   }