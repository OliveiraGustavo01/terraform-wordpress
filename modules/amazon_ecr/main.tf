locals {
  _name       = var.use_fullname ? module.this.id : module.this.name
  image_names = length(var.image_names) > 0 ? var.image_names : [local._name]
}

resource "aws_ecr_repository" "foo" {
  for_each             = toset(module.this.enabled ? local.image_names : [])
  name                 = each.value
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration  {
    scan_on_push = true

  }
}