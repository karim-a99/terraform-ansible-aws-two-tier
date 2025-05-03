provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "hvs.t894QhDvdnVtV48VPubR57xp"

}
data "vault_kv_secret_v2" "aws" {
  mount = "secret"
  name  = "aws"

}
provider "aws" {
  region     = "us-east-1"
  access_key = data.vault_kv_secret_v2.aws.data["access_key"]
  secret_key = data.vault_kv_secret_v2.aws.data["secret_key"]

}