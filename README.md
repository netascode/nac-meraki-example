# nac-meraki-example

Sample Meraki as Code repository for the [Meraki as Code Learning Lab](https://netascode.cisco.com/docs/guides/meraki/learning_lab/0_lab_overview/).

## Overview

This repository provides a ready-to-use project structure for managing Meraki infrastructure as code. It uses Terraform, YAML data models, and the [NaC Meraki module](https://github.com/netascode/terraform-meraki-nac-meraki) to declaratively define and deploy configuration to the Meraki Dashboard.

## Repository Structure

```text
.
├── .ci/                   # CI/CD helper scripts (GitLab comments, Webex notifications)
├── data/                  # Your YAML data model files go here (empty by default)
├── lab-data/              # Pre-built YAML files for each lab exercise step
├── rules/                 # Custom nac-validate Python rules for semantic validation
├── workspaces/            # Separate Terraform workspace for template rendering
├── tests/                 # Templates for post-deployment testing with nac-test
├── .gitlab-ci.yml         # GitLab CI/CD pipeline definition
├── main.tf                # Root Terraform configuration
├── schema.yaml            # YAML schema for data model validation
└── LICENSE
```

## Prerequisites

- Terraform >= 1.9.0 (or OpenTofu)
- Python 3.12
- Meraki API Key with full write access ([Enable API access](https://documentation.meraki.com/General_Administration/Other_Topics/The_Cisco_Meraki_Dashboard_API#Enable_API_access))

## Quick Start

Clone and switch to the repository:

```bash
git clone --depth 1 https://github.com/netascode/nac-meraki-example meraki-as-code
cd meraki-as-code
```

Set environment variables (create a `.env` file):

```bash
export MERAKI_API_KEY=<your_api_key>
export secret_password=<your_secret_in_datamodel>
export org_email=<your_email>
```

```bash
source .env
```

Copy the desired configuration from `lab-data/` into the `data/` folder:

```bash
cp lab-data/01_create_org.nac.yaml data/
```

Validate, plan, deploy, and test:

```bash
nac-validate --non-strict -s schema.yaml -r rules/ data/
terraform init
terraform plan
terraform apply
nac-test --templates tests/ --data data/ --output test_results
```

## Key References

- [NaC Meraki Terraform Module](https://registry.terraform.io/modules/netascode/nac-meraki/meraki/latest)
- [Meraki Terraform Provider](https://registry.terraform.io/providers/CiscoDevNet/meraki/latest)
- [Meraki Data Model Reference](https://netascode.cisco.com)
- [nac-validate](https://github.com/netascode/nac-validate)
- [nac-test](https://github.com/netascode/nac-test)

## License

See the [LICENSE](LICENSE) file for details.
