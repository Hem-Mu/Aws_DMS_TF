resource "aws_dms_endpoint" "target" {
  # certificate_arn             = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  database_name               = "target" # 생성될 DB 이름

  endpoint_id                 = "source-to-target-endpoint-tf" # identifier
  endpoint_type               = "target"
  engine_name                 = "docdb"
  extra_connection_attributes = "" # 추가 연결 속성 https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.PostgreSQL.html#CHAP_Source.PostgreSQL.ConnectionAttrib
  # kms_key_arn                 = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  username                    = "hamster" # DB USER
  password                    = "hamster1" # DB USER PW
  port                        = 27017
  server_name                 = data.terraform_remote_state.docdb.outputs.cluster_add # local private IP ##
  ssl_mode                    = "none"

  tags = {
    Name = "test"
  }
}