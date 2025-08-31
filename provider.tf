terraform {
required_version = ">= 1.5.0"
required_providers {
aws = {
source = "hashicorp/aws"
version = ">= 6.0"
}
archive = {
source = "hashicorp/archive"
version = ">= 2.4"
}
random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
}
}


provider "aws" {
region = var.region
}


locals {
app_name = var.app_name
tags     = merge( var.tags,{"Project" = var.app_name})
}