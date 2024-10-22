locals {
  # example names on how they look, 
  # samapsud, samapsstg, samapspn (using a combination of letters)
  prefix = "sa"
  name   = "${local.prefix}${var.main_project}${var.sub_project}${var.environment}"
}
