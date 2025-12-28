data "aws_availability_zones" "available" {
    state = "available"
}

data "terraform_remote_state" "Compute" {
  backend = "local"
  config = {
    path = "../Compute/terraform.tfstate"
  }
}

resource "aws_ebs_volume" "test_volume" {
    availability_zone = data.aws_availability_zones.available.names[0]
    size = var.volume_size
    tags = merge(var.tags, { Name = "Test_EBS_Volume" })
}

resource "aws_volume_attachment" "test_volume_attachment" {
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.test_volume.id
    instance_id = data.terraform_remote_state.Compute.outputs.aws_webserver_id[0]
}

resource "aws_ebs_snapshot" "test_ebs_snapshot" {
    volume_id = aws_ebs_volume.test_volume.id
    tags = merge(var.tags, { Name = "Test_EBS_Snapshot"})
}
