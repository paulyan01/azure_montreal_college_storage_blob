output "id" {
  value = [
    for name in local.clusters_name: name
  ]
}
