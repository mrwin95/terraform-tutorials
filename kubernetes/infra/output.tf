output "control-plane-ip" {
  value = aws_instance.instance_master.public_ip
}

output "w1-ip" {
  value = aws_instance.instance_wk1.public_ip
}
output "w2-ip" {
  value = aws_instance.instance_wk2.public_ip
}

