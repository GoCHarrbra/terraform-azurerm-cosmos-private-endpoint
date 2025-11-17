# terraform-azurerm-cosmos-private-endpoint

This repository provides Terraform configuration to create an Azure Cosmos DB account with a Private Endpoint (private link) in Microsoft Azure. This README will help you get started quickly using Visual Studio Code (VS Code) for development, testing, and deploying the Terraform code.

> Note: This README is written as a general guide. Adjust provider versions, resource names, and configuration to fit your organization's policies and naming conventions.

## Table of contents
- What this repo contains
- Prerequisites
- Quickstart (local)
- Environment variables and secrets
- Recommended VS Code setup
- Useful commands and VS Code tasks
- Troubleshooting & tips
- Contributing

## What this repo contains
- Terraform code to create an Azure Cosmos DB account and associated Private Endpoint configuration.
- Example variable files (if present in repo).
- (Optional) Guidance to configure remote state backends such as Azure Storage.

## Prerequisites
- Terraform CLI (recommended >= 1.4.x). Install from https://www.terraform.io.
- Azure CLI (az) installed and signed in: https://docs.microsoft.com/cli/azure/install-azure-cli
- An Azure subscription with permissions to create Cosmos DB, networking components and storage (if using remote state).
- (Recommended) A service principal for automation and CI/CD:
  - az ad sp create-for-rbac --name "tf-cosmos-sp" --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"

## Quickstart (local)
1. Clone the repo
   - git clone https://github.com/GoCHarrbra/terraform-azurerm-cosmos-private-endpoint.git
   - cd terraform-azurerm-cosmos-private-endpoint

2. Authenticate to Azure
   - For interactive development: az login
   - For CI / non-interactive: export the following environment variables (see next section)

3. Initialize Terraform
   - terraform init

4. Validate and format
   - terraform fmt -recursive
   - terraform validate

5. Plan and apply
   - terraform plan -out=tfplan -var-file="example.tfvars"
   - terraform apply "tfplan"

6. Destroy (when needed)
   - terraform destroy -var-file="example.tfvars"

Replace `example.tfvars` with the path to your variable file. If you don't have one, create a minimal `terraform.tfvars` with the variables required by the module/configuration.

## Environment variables and secrets
Set these environment variables when running Terraform so sensitive values are not checked into source:

- ARM_SUBSCRIPTION_ID
- ARM_TENANT_ID
- ARM_CLIENT_ID
- ARM_CLIENT_SECRET

Example (bash):
export ARM_SUBSCRIPTION_ID="your-sub-id"
export ARM_TENANT_ID="your-tenant-id"
export ARM_CLIENT_ID="your-sp-client-id"
export ARM_CLIENT_SECRET="your-sp-client-secret"

If you use a remote backend like Azure Storage for state, configure the backend in `backend.tf` or pass backend configuration during `terraform init`.

## Recommended VS Code setup
Install these extensions for the best Terraform + Azure experience:
- HashiCorp Terraform (hashicorp.terraform)
- Azure Account (ms-vscode.azure-account)
- Azure CLI Tools (ms-vscode.vscode-node-azure-pack) or Azure Tools (ms-vscode.vscode-azureextensionpack)
- GitLens — Git supercharged (eamodio.gitlens)
- EditorConfig for VS Code (EditorConfig.EditorConfig)

Example .vscode/settings.json suggestions:
{
  "editor.formatOnSave": true,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "terraform.formatOnSave": true,
  "terraform.path": "terraform" 
}

Notes:
- "terraform.path" can be set to the absolute path of your terraform binary if needed.
- The HashiCorp Terraform extension provides syntax highlighting, validation and code completion.

## Useful VS Code tasks
You can add these tasks in `.vscode/tasks.json` to run common Terraform commands from the VS Code Command Palette.

Example tasks.json snippet:
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "terraform fmt",
      "type": "shell",
      "command": "terraform fmt -recursive",
      "problemMatcher": []
    },
    {
      "label": "terraform init",
      "type": "shell",
      "command": "terraform init",
      "problemMatcher": []
    },
    {
      "label": "terraform validate",
      "type": "shell",
      "command": "terraform validate",
      "problemMatcher": []
    },
    {
      "label": "terraform plan",
      "type": "shell",
      "command": "terraform plan -out=tfplan -var-file=\"example.tfvars\"",
      "problemMatcher": []
    },
    {
      "label": "terraform apply",
      "type": "shell",
      "command": "terraform apply \"tfplan\"",
      "problemMatcher": []
    },
    {
      "label": "terraform destroy",
      "type": "shell",
      "command": "terraform destroy -var-file=\"example.tfvars\"",
      "problemMatcher": []
    }
  ]
}

Adjust the var-file names and commands to match your repo layout.

## Troubleshooting & tips
- If Terraform complains about provider versions, pin a compatible azurerm provider in `required_providers` with a tested version range.
- Use `terraform state list` and `terraform state show <resource>` to inspect resources if something diverges.
- For network/private endpoint debugging: ensure the Private DNS zones or DNS forwarding are configured so the Cosmos DB account's private endpoint name resolves from your VNet.
- Keep secrets out of repo: use Azure Key Vault, environment variables, or CI/CD secret stores.

## Contributing
- Open an issue or a PR for improvements.
- Follow standard GitFlow: branch from main, make changes, open PR, request review.
- Add tests (if you add modules or re-usable code) and update README accordingly.

## License
Add your license information here (e.g., MIT, Apache 2.0) or create a LICENSE file in the repository.
