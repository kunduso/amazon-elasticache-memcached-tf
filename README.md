[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/) [![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/amazon-elasticache-memcached-tf)](https://github.com/kunduso/amazon-elasticache-memcached-tf/pulls?q=is%3Apr+is%3Aclosed) [![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/amazon-elasticache-memcached-tf)](https://GitHub.com/kunduso/amazon-elasticache-memcached-tf/pull/) 
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/amazon-elasticache-memcached-tf)](https://github.com/kunduso/amazon-elasticache-memcached-tf/issues?q=is%3Aissue+is%3Aclosed) [![GitHub issues](https://img.shields.io/github/issues/kunduso/amazon-elasticache-memcached-tf)](https://GitHub.com/kunduso/amazon-elasticache-memcached-tf/issues/) 
[![terraform-infra-provisioning](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/terraform.yml/badge.svg?branch=main)](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/terraform.yml) [![checkov-static-analysis-scan](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/code-scan.yml/badge.svg?branch=main)](https://github.com/kunduso/amazon-elasticache-memcached-tf/actions/workflows/code-scan.yml)



## Prerequisites
For this code to function without errors, I created an **OpenID connect** identity provider in **Amazon Identity and Access Management** that has a trust relationship with this GitHub repository. You can read about it [here](https://skundunotes.com/2023/02/28/securely-integrate-aws-credentials-with-github-actions-using-openid-connect/) to get a detailed explanation with steps.
<br />I stored the ARN of the IAM Role as a GitHub secret which is referred in the [`terraform.yml`]() file.
<br />Since I used Infracost in this repository, I stored the `INFRACOST_API_KEY` as a repository secret. It is referenced in the [`terraform.yml`]() GitHub actions workflow file.
<br />As part of the Infracost integration, I also created a `INFRACOST_API_KEY` and stored that as a GitHub Actions secret. I also managed the cost estimate process using a GitHub Actions variable `INFRACOST_SCAN_TYPE` where the value is either `hcl_code` or `tf_plan`, depending on the type of scan desired.
## Usage
Ensure that the policy attached to the IAM role whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.

<br />Review the code including the [`terraform.yml`](./.github/workflows/terraform.yml) to understand the steps in the GitHub Actions pipeline. Also review the terraform code to understand all the concepts associated with creating an AWS VPC, subnets, internet gateway, route table, and route table association.
<br />If you want to check the pipeline logs, click on the **Build Badge** (terrform-infra-provisioning) above the image in this ReadMe.
## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).