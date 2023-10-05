output "id" {
  value = [
    for name in local.clusters_name: name
  ]
}
/*output "linux_app"{
    value = [
      for name in local.linux_app: name
  ]
}
output "linux_app_list"{
    value = [
      for name in local.linux_app_list: name
  ]
}
