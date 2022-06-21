resource "aws_dms_endpoint" "source" {
  # certificate_arn             = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  database_name               = "source" # 생성될 DB 이름

  endpoint_id                 = "test-dms-endpoint-tf" # identifier
  endpoint_type               = "source"
  engine_name                 = "mongodb"
  extra_connection_attributes = "" # 추가 연결 속성 https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.PostgreSQL.html#CHAP_Source.PostgreSQL.ConnectionAttrib
  # kms_key_arn                 = "" # kms키를 사용하지 않으면 default key사용

  username                    = "dms" # DB USER
  password                    = "1234" # DB USER PW
  port                        = 27017
  server_name                 = "10.100.0.5" # local private IP ##
  ssl_mode                    = "none"

  mongodb_settings {
    auth_mechanism = "default"
    auth_source = "hamster" # NAME + PW로 인증 받을 DB 이름 /DB NAME
    auth_type = "password" # 인증 타입
    nesting_level = "none" # none = document, one = table
  }

  tags = {
    Name = "test"
  }

  depends_on = [
    aws_dms_replication_instance.rp_instance
  ]
}
output "souce_arn" {
     value = "${aws_dms_endpoint.source.endpoint_arn}" # cert arn
   }