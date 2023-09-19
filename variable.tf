variable "client_id"{
  type=string
}
variable "client_secret"{
  type=string
}
variable "subscription_id"{
  type=string
}
variable "tenant_id"{
  type=string
}
variable "account_tier"{
  type=string
  default="Standard"
}
variable "prefix"{
  default="mcitblob"
}
variable "address_space"{
  type=list(string)
  default=["10.0.0.0/16","10.0.1.0/24"]
}
