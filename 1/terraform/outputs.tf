output "jump_box_ip" {
  value = module.compute.jump_box_ip
}

output "app_instance_ip" {
  value = module.compute.private_ip
}