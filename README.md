[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/) [![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/amazon-elasticache-memcached-tf)](https://github.com/kunduso/amazon-elasticache-memcached-tf/pulls?q=is%3Apr+is%3Aclosed) [![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/amazon-elasticache-memcached-tf)](https://GitHub.com/kunduso/amazon-elasticache-memcached-tf/pull/) 
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/amazon-elasticache-memcached-tf)](https://github.com/kunduso/amazon-elasticache-memcached-tf/issues?q=is%3Aissue+is%3Aclosed) [![GitHub issues](https://img.shields.io/github/issues/kunduso/amazon-elasticache-memcached-tf)](https://GitHub.com/kunduso/amazon-elasticache-memcached-tf/issues/) 
[![terraform-infra-provisioning](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/terraform.yml/badge.svg?branch=main)](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/terraform.yml) [![checkov-static-analysis-scan](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/code-scan.yml/badge.svg?branch=main)](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/code-scan.yml) [![Generate terraform docs](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/documentation.yml/badge.svg)](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/documentation.yml)
![Image](https://skdevops.files.wordpress.com/2024/08/100-image-0.png)
## Introduction
This repository contains the Terraform code to provision an Amazon ElastiCache for Memcached and all the supporting infrastructure components like Amazon VPC, subnets, and security group using Terraform. It also contains the additional code to access the ElastiCache cluster from an Amazon EC2 instance.
<br/>I discussed **both** the concept in detail in my notes at -[create Amazon ElastiCache for Memcached using Terraform and GitHub Actions](http://skundunotes.com/2024/08/16/create-amazon-elasticache-for-memcached-using-terraform-and-github-actions/) and [access Amazon ElastiCache for Memcached from an Amazon EC2 instance using Python.](https://skundunotes.com/2024/08/21/access-amazon-elasticache-for-memcached-from-an-amazon-ec2-instance-using-python/)

<br />I used **Bridgecrew Checkov** to scan the Terraform code for security vulnerabilities. Here is a link if you are interested in adding code scanning capabilities to your GitHub Actions pipeline [-automate-terraform-configuration-scan-with-checkov-and-github-actions](https://skundunotes.com/2023/04/12/automate-terraform-configuration-scan-with-checkov-and-github-actions/).
<br />I also used **Infracost** to generate a cost estimate of building the architecture. If you want to learn more about adding Infracost estimates to your repository, head over to this note [-estimate AWS Cloud resource cost with Infracost, Terraform, and GitHub Actions](https://skundunotes.com/2023/07/17/estimate-aws-cloud-resource-cost-with-infracost-terraform-and-github-actions/).
<br />Lastly, I also automated the process of provisioning the resources using **GitHub Actions** pipeline and I discussed that in detail at [-CI-CD with Terraform and GitHub Actions to deploy to AWS](https://skundunotes.com/2023/03/07/ci-cd-with-terraform-and-github-actions-to-deploy-to-aws/).

## Prerequisites
For this code to function without errors, I created an **OpenID connect** identity provider in **Amazon Identity and Access Management** that has a trust relationship with this GitHub repository. You can read about it [here](https://skundunotes.com/2023/02/28/securely-integrate-aws-credentials-with-github-actions-using-openid-connect/) to get a detailed explanation with steps.
<br />I stored the ARN of the IAM Role as a GitHub secret which is referred in the [`terraform.yml`](https://github.com/kunduso/amazon-elasticache-memcached-tf/blob/cd2aa394bea3f3f6421cfa559f6a8b5f8b6d9ee8/.github/workflows/terraform.yml#L42) file.
<br />Since I used Infracost in this repository, I stored the `INFRACOST_API_KEY` as a repository secret. It is referenced in the [`terraform.yml`](https://github.com/kunduso/amazon-elasticache-memcached-tf/blob/cd2aa394bea3f3f6421cfa559f6a8b5f8b6d9ee8/.github/workflows/terraform.yml#L52) GitHub actions workflow file.
<br />As part of the Infracost integration, I also created a `INFRACOST_API_KEY` and stored that as a GitHub Actions secret. I also managed the cost estimate process using a GitHub Actions variable `INFRACOST_SCAN_TYPE` where the value is either `hcl_code` or `tf_plan`, depending on the type of scan desired.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/kunduso/terraform-aws-vpc | v1.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_cluster.cache_cluster](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_subnet_group.elasticache_subnet](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/elasticache_subnet_group) | resource |
| [aws_iam_instance_profile.ec2_profile](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ssm_parameter_policy](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_policy_attachement](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.read_instance](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/instance) | resource |
| [aws_instance.write_instance](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/instance) | resource |
| [aws_kms_alias.encryption_secret](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.encrypt_ssm](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.encrypt_ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/kms_key_policy) | resource |
| [aws_security_group.custom_sg](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/security_group) | resource |
| [aws_security_group.instance_sg](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_custom_sg](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_instance_sg](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_custom_sg](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.elasticache_ep](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/ssm_parameter) | resource |
| [aws_ami.ec2_ami](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.encrypt_ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | The access\_key that belongs to the IAM user | `string` | `""` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The availability zones for teh public subnets. | `list(any)` | <pre>[<br/>  "us-east-2a",<br/>  "us-east-2b"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the application. | `string` | `"app-10"` | no |
| <a name="input_region"></a> [region](#input\_region) | Infrastructure region | `string` | `"us-east-2"` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | The secret\_key that belongs to the IAM user | `string` | `""` | no |
| <a name="input_subnet_cidr_private"></a> [subnet\_cidr\_private](#input\_subnet\_cidr\_private) | The CIDR blocks for the private subnets. | `list(any)` | <pre>[<br/>  "12.25.15.64/27",<br/>  "12.25.15.96/27"<br/>]</pre> | no |
| <a name="input_subnet_cidr_public"></a> [subnet\_cidr\_public](#input\_subnet\_cidr\_public) | The CIDR blocks for the public subnets. | `list(any)` | <pre>[<br/>  "12.25.15.0/27",<br/>  "12.25.15.32/27"<br/>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR of the VPC. | `string` | `"12.25.15.0/25"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
## Usage
Ensure that the policy attached to the IAM role whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.

<br />Review the code including the [`terraform.yml`](./.github/workflows/terraform.yml) to understand the steps in the GitHub Actions pipeline. Also review the terraform code to understand all the concepts associated with creating an AWS VPC, subnets, internet gateway, route table, and route table association.
<br />If you want to check the pipeline logs, click on the **Build Badge** (terrform-infra-provisioning) above the image in this ReadMe.
## Contributing
If you find any issues or have suggestions for improvement, feel free to open an issue or submit a pull request. Contributions are always welcome!
## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).