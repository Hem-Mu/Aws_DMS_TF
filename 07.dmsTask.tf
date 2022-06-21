resource "aws_dms_replication_task" "test" {
  # cdc_start_time            = 1655776843 # 작업 시작 시간 Unix 타임스탬프로 표현함 https://www.epochconverter.com/
  migration_type            = "full-load"
  
  replication_task_id       = "dms-replication-task"
  # replication_task_settings = "..." # 작업설정 JSON https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TaskSettings.html
  
  table_mappings            = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"%\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"
    # 매핑 JSON https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.html
  tags = {
    Name = "test"
  }

  replication_instance_arn  = aws_dms_replication_instance.rp_instance.replication_instance_arn # 복제인스턴스

  source_endpoint_arn       = aws_dms_endpoint.source.endpoint_arn # 소스엔드포인트
  target_endpoint_arn = aws_dms_endpoint.target.endpoint_arn # 타겟엔드포인트
}