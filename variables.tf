variable "base_name" {
  type    = string
  default = "dumcloud"
}

variable "common_tags" {
  description = "Common tags to attach to every object"

  default = {
    Project = "tf-dumcloud-infra"
  }
}
