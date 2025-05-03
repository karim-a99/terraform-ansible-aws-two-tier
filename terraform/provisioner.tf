resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = <<EOT
    echo "[web]" > ../ansible/inventory.ini
    echo "${aws_instance.web1.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/my-key.pem" >> ../ansible/inventory.ini
    echo "${aws_instance.web2.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/my-key.pem" >> ../ansible/inventory.ini
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml
    EOT
  }


  depends_on = [
    aws_instance.web1,
    aws_instance.web2
  ]
}