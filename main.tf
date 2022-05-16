#load data sources based on variables of other modules.
#You need -var-file argument in terraform commands to specify the variables of other root module
#The benefit is to split the terraform state in different workspace/modules
locals {
  #get the path of the csv files in the csv-input folder (found in the path.module/csv-input
  #policiespath = fileset(path.module, "csv-input/*.csv")
}

#module "nsxt-cm-groups" {
module "group" {
  source  = "onprem-tfe-prod.wwmgmt.intraxa/network/group/nsxt"

  #source = "git::https://github.axa.com/go-network/nsxt-tf-modules.git//nsxt-cm-groups"
  #The below declaration is to use the local module to develop/change the module.
  #source = "C:\\Users\\boulene-adm\\Desktop\\script\\nsxt\\nsxt-tf-modules\\nsxt-cm-groups"
  mapgroups = var.mapgroups
}

#module "nsxt-cm-services" {
module "service" {
  #source = "git::https://github.axa.com/go-network/nsxt-tf-modules.git//nsxt-cm-services"
  source  = "onprem-tfe-prod.wwmgmt.intraxa/network/service/nsxt"
  #The below declaration is to use the local module to develop/change the module.
  #source = "C:\\Users\\boulene-adm\\Desktop\\script\\nsxt\\nsxt-tf-modules\\nsxt-cm-services"
  mapservices = var.mapservices
}

#to be replacer by the remote state where we create the T1
#data "nsxt_policy_tier1_gateway" "t1gws" {
#  for_each = toset(var.t1gws["T1s"])
#  display_name = each.key
#}


#Load the child modules stored in git, there is no data in the child modules. 
#The variable are store in the local project where there are 3 root modules. Groups, Services and Rules
  #module "rule" {
  #source  = "onprem-tfe-prod.wwmgmt.intraxa/network/rule/nsxt"
  #version = "1.0.21"
  module "rule-scope" {
  source  = "onprem-tfe-prod.wwmgmt.intraxa/network/rule-scope/nsxt"
  version = "1.0.1"
  #csvfolderpath = local.policiespath
  #pass the path to the child module
  #Local variable of the rules root module
  mappolicies = var.mappolicies
  mappolicies_gwfw = var.mappolicies_gwfw
  mapgroups = var.mapgroups
  #essayer d'utiliser le module.group.groups au lieu de mapgroups
  nsxt_policy_group_groups = module.group.groups
  nsxt_policy_service_services = module.service.services
  
  #Other variable in the groups and services root modules
  #nsxt_policy_tier1_gateway_t1gws = data.nsxt_policy_tier1_gateway.t1gws
  nsxt_policy_tier1_gateway_t1gws = {}
  depends_on = [ module.group, module.service ]
}

output test {
  value = module.group.groups
}
output "debug" {
#value = module.rule-v2
 value = module.rule-scope
}
 
