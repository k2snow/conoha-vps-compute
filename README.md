# conoha-vps-compute

## Overview
Manages a V2 VM instance resource within ConoHa VPS (OpenStack).

## Requirements
- [ConoHa VPS](https://www.conoha.jp/vps/?btn_id=top_vps)
- terraform >= 0.14.0

## Preparation
- ConoHa VPS API
  - API USER NAME
  - API USER PASSWORD
  - API TENANT NAME
  - API ENDPOINT(Identity Service)
- SSH Public key
  - A pregenerated OpenSSH-formatted public key. 
- Select VM instance images
```
$ curl -s -X GET -H "Accept: application/json" -H "X-Auth-Token: ${TOKEN}" ${Image Service Endpoint}/v2/images | jq ".images | sort_by(.name) | map(.name)"

...(snip)...
  "vmi-centos-7.9-amd64",
  "vmi-centos-7.9-amd64-100gb",
  "vmi-centos-7.9-amd64-20gb",
  "vmi-centos-7.9-amd64-30gb",
...(snip)...
```

- Select ConoHa VPS Plan(flavor)
```
$ curl -s -X GET -H "Accept: application/json" -H "X-Auth-Token: ${TOKEN}" ${Compute Service Endpoint}/v2/${tenant_id}/flavors | jq ".flavors | sort_by(.name) | map(.name)"
[
  "g-16gb",
  "g-1gb",
  "g-2gb",
  "g-32gb",
  "g-4gb",
  "g-512mb",
  "g-64gb",
  "g-8gb",
  "g-c12m32d100",
  "g-c1m512d30",
  "g-c24m64d100",
  "g-c2m1d100",
  "g-c3m2d100",
  "g-c4m4d100",
  "g-c6m8d100",
  "g-c8m16d100"
]
```
- Select Security Group
```
$ curl -s -X GET -H "Accept: application/json" -H "X-Auth-Token:  ${TOKEN}" ${Network Service Endpoint}/v2.0/security-groups | jq ".security_groups | map(.name)"
[
  "gncs-ipv4-all",
  "gncs-ipv6-all",
  "default",
  "gncs-ipv4-ssh",
  "gncs-ipv4-web"
]
```


## Setup
- create terraform.tfvars(secure data)
```
$ vi terraform.tfvars
user_name                = "${API USER NAME}"
password                 = "${API USER PASSWORD}"
tenant_name              = "${API TENANT NAME}"
auth_url                 = "${API ENDPOINT}"
import_public_key_name   = "${IMPORT PUBLIC KEY NAME}"
public_key               = "${SSH Public key}"
```

## Usage
- create vm instance
```
$ terraform init
$ terraform plan
$ terraform apply
```

## References
- [ConoHa API Documantation](https://www.conoha.jp/docs/)
- [Terraform - OpenStack Provider](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs)

## Licence
This software is released under the MIT License.
