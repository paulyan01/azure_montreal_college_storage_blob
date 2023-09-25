output "id" {
  value = [
    for name in local.name: name
  ]
}
