resource "aws_dms_replication_subnet_group" "rp_subnet" {
  replication_subnet_group_description = "Test replication subnet group"
  replication_subnet_group_id          = data.terraform_remote_state.network.outputs.vpc_id

  subnet_ids = [
    data.terraform_remote_state.network.outputs.pub1_id, 
    data.terraform_remote_state.network.outputs.pub2_id,
    data.terraform_remote_state.network.outputs.pri1_id, 
    data.terraform_remote_state.network.outputs.pri2_id
  ]

  tags = {
    Name = "DMS-Subnet"
  }
}