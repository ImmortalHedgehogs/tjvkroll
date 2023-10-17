variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "TerraformWithAnsibleRunnerTK"
}

variable "pvt_key" {
  description = "Private key location locally"
  type        = string
  default     = "/Users/traviskroll/git/Liatrio/BootcampExercises/7-InfrastructureAndConfiguration/Ansible/7.2Ansible/Ex3_Terraform_Ansible/Travis_ansible_key.pem"
}

variable "pub_key" {
  description = "Public key location locally"
  type        = string
  default     = ""
}

