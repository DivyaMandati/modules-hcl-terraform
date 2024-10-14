locals {
  # exmaple names on how they look, 
  # rg-sas-psu-dev,  rg-sas-psu-qa,  rg-sas-psu-stg
  # rg-sas-nrm-dev, rg-sas-nrm-stg, rg-sas-nrm-prod
  prefix = "rg"
  name   = "${local.prefix}-${var.main_project}-${var.sub_project}-${var.environment}"
}

