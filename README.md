# OpenStack Security Group Terraform Module

## Usage

### Security group with pre-defined rules

```hcl
module "sg" {
  source = "./modules/terraform-openstack-modules/terraform-openstack-security"

  name          = "staging-sg"
  ingress_cidr  = "10.20.30.0/24"
  ingress_rules = ["ssh-tcp"]
  tags          = ["staging"]
}
```

### Security group with custom rules

```hcl
module "sg" {
  source = "./modules/terraform-openstack-modules/terraform-openstack-security"

  name          = "custom-sg"
  ingress_with_cidr_blocks = [
    {
      rule       = "postgresql-tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      rule       = "postgresql-tcp"
      cidr_block = "30.30.30.30/32"
    },
    {
      from_port   = 10
      to_port     = 20
      protocol    = 6
      description = "Service name"
      cidr_block  = "10.10.0.0/20"
    },
  ]
  tags          = ["staging"]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | >= 1.35.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | >= 1.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_networking_secgroup_rule_v2.ingress_rules](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_rule_v2) | resource |
| [openstack_networking_secgroup_rule_v2.ingress_with_cidr_blocks](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_rule_v2) | resource |
| [openstack_networking_secgroup_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_sg"></a> [create\_sg](#input\_create\_sg) | Whether to create security group | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| <a name="input_ingress_cidr"></a> [ingress\_cidr](#input\_ingress\_cidr) | IPv4 CIDR to use on all ingress rules | `string` | `"0.0.0.0/0"` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_ingress_with_cidr_blocks"></a> [ingress\_with\_cidr\_blocks](#input\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of security group - not required if create\_sg is false | `string` | `null` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | ID of existing security group whose rules we will manage | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to assign to security group | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
