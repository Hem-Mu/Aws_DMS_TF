data "aws_iam_policy_document" "dms_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "dms-access-for-endpoint" {
  assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json
  name               = "dms-access-for-endpoint"
}
resource "aws_iam_role_policy_attachment" "dms-access-for-endpoint-AmazonDMSRedshiftS3Role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSRedshiftS3Role"
  role       = aws_iam_role.dms-access-for-endpoint.name
}
#
resource "aws_iam_role" "dms-cloudwatch-logs-role" {
  assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json
  name               = "dms-cloudwatch-logs-role"
}
resource "aws_iam_role_policy_attachment" "dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
  role       = aws_iam_role.dms-cloudwatch-logs-role.name
}
#
resource "aws_iam_role" "dms-vpc-role" {
  assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json
  name               = "dms-vpc-role"
}
resource "aws_iam_role_policy_attachment" "dms-vpc-role-AmazonDMSVPCManagementRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  role       = aws_iam_role.dms-vpc-role.name
}

# Create a new replication instance
resource "aws_dms_replication_instance" "rp_instance" {
  allocated_storage            = 20 # 인스턴스 용량 5~6144
  apply_immediately            = true # 변경사항 즉시 적용
  auto_minor_version_upgrade   = true # 버전 자동 업데이트
  availability_zone            = "ap-northeast-2a"
  engine_version               = "3.4.6"
  #kms_key_arn                  = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # kms를 설정하지 않으면 기본 aws kms 사용
  multi_az                     = false # 멀티 가용영역 
  preferred_maintenance_window = "sun:10:30-sun:14:30" # 유지 관리 시간 범위
  publicly_accessible          = false # 공용 IP 할당 여부
  replication_instance_class   = "dms.t2.micro"
  replication_instance_id      = "dms-replication-instance"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.rp_subnet.id

  tags = {
    Name = "dms_instance"
  }

  /* vpc_security_group_ids = [
    "sg-12345678",
  ] */

  depends_on = [
    aws_iam_role_policy_attachment.dms-access-for-endpoint-AmazonDMSRedshiftS3Role,
    aws_iam_role_policy_attachment.dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole,
    aws_iam_role_policy_attachment.dms-vpc-role-AmazonDMSVPCManagementRole,
    aws_dms_replication_subnet_group.rp_subnet
  ]
}
output "rp_instance_arn" {
     value = "${aws_dms_replication_instance.rp_instance.replication_instance_arn}" # cert arn
   }
   # 복제 인스턴스 생성 시 NI가 자동으로 생성되는데 terraform destroy시 NI가 함께 제거되지 않음 