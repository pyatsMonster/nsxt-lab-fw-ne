variable "password" {
}

#map of list, every list name is the group name and contain the tags associated with the group
variable "mappolicies" {
   type = map
   default = {
   }
}
#launch
variable "csvfolderpath" {
   type = list
   default = []
   }
variable "mappolicies_gwfw" {
   type = map
   default = {
   }
}

variable "t1gws" {
   type = map
   default = {
   }
}

variable "mapgroups" {
   type = map
   default = {
   }
}

variable "mapservices" {
   type = map
   default = {
   }
}
