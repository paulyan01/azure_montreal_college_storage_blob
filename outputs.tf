output "id" {
  value = [
    for name in local.clusters_name: name
  ]
}
output "linux_app"{
    value=local.linux_app
}
output "linux_app_list"{
    value=local.linux_app_list
}
