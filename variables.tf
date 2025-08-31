variable "region" {
  default = "ap-south-1"
}

variable "app_name" {
  default = "collage-fest"
}

variable "frontend_build_dir" {
  default = "./frontend_build"
}

variable "upload_frontend" {
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}