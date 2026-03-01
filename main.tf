# terraform {
#   backend "http" {
#     skip_cert_verification = true
#   }
# }

module "meraki" {
  source           = "github.com/netascode/terraform-meraki-nac-meraki"
  yaml_directories = ["data"]
}
