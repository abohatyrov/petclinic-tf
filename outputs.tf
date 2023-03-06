output "Jenkins_External_IPAddr" {
  value = module.jenkins_instance.IpAddr
}

output "K8s_Cluster_IPAddr" {
  value = module.k8s_cluster.ip_addres
}
