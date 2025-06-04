# Using GitHub, Terraform/Bicep, and GitHub Copilot for Microsoft Cloud Solution Architects

## Objective
This training will teach Microsoft Cloud Solution Architects how to:
1. Use GitHub as a code repository for collaboration and sharing.
2. Leverage Terraform and Bicep to deploy simple Azure services.
3. Use Visual Studio Code (VSCode) and GitHub Copilot to streamline development.
4. Interact with GitHub Copilot Chat to solve problems and accomplish tasks.

---

## Agenda
1. **Introduction to GitHub**  
   - Overview of GitHub and its role in code collaboration.
   - Setting up a GitHub repository.
   - Basic Git commands and workflows in VSCode.

2. **Introduction to Infrastructure as Code (IaC)**  
   - Overview of Terraform and Bicep.
   - When to use Terraform vs. Bicep.
   - Setting up the environment for IaC development.

3. **Hands-On: Deploying Azure Services**  
   - Writing a simple Terraform script to deploy an Azure Storage Account.
   - Writing a simple Bicep template to deploy an Azure Web App.
   - Deploying resources to Azure using the Azure CLI.

4. **Using GitHub Copilot and Copilot Chat in VSCode**  
   - Setting up GitHub Copilot in VSCode.
   - Writing Terraform and Bicep templates with GitHub Copilot.
   - Using GitHub Copilot Chat to solve problems and generate code.

5. **Collaborating with GitHub**  
   - Creating branches and pull requests.
   - Reviewing and merging code.
   - Sharing repositories with customers or other teams.

6. **Wrap-Up and Q&A**  
   - Recap of key concepts.
   - Open Q&A session.

---

## Training Content with GitHub Copilot Chat Integration

### 1. Introduction to GitHub
- **Resources**:
  - [GitHub Docs: Getting Started](https://docs.github.com/en/get-started)
  - [Git Basics Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- **Hands-On**:
  1. Create a GitHub account (if not already done).
  2. Create a new repository in GitHub.
  3. Clone the repository to your local machine using VSCode:
     ```bash
     git clone https://github.com/<your-username>/<repository-name>.git
     ```
  4. Add a README file, commit, and push changes:
     ```bash
     echo "# My First Repo" > README.md
     git add README.md
     git commit -m "Initial commit"
     git push origin main
     ```
  5. **Ask GitHub Copilot Chat**:  
     - "How do I create a new branch in Git and push it to GitHub?"  
     - Follow the instructions provided by Copilot Chat.

---

### 2. Introduction to Terraform and Bicep
- **Resources**:
  - [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
  - [Bicep Docs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- **Hands-On**:
  1. Install Terraform and Azure CLI:
     - [Terraform Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
     - [Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
  2. Install the Bicep CLI:
     ```bash
     az bicep install
     ```
  3. Verify installations:
     ```bash
     terraform --version
     az bicep version
     ```
  4. **Ask GitHub Copilot Chat**:  
     - "How do I install Terraform on Windows?"  
     - "What is the command to install the Bicep CLI using Azure CLI?"

---

### 3. Deploying Azure Services
- **Terraform Example (Best Practices):**
  1. Create a subfolder named `terraform-demo` in your project directory and open it in VSCode.
  2. Inside `terraform-demo`, create a file named `main.tf` and paste the following code:
     ```hcl
     provider "azurerm" {
       features {}
     }

     resource "azurerm_storage_account" "example" {
       name                     = "examplestorageacct"
       resource_group_name      = "example-rg"
       location                 = "East US"
       account_tier             = "Standard"
       account_replication_type = "LRS"
     }
     ```
  3. In the same folder, create a file named `variables.tf` to define variables (optional for this simple example, but recommended for best practices).
  4. Open a terminal in VSCode, navigate to the `terraform-demo` folder, and run:
     ```bash
     terraform init
     terraform validate
     terraform plan
     terraform apply -auto-approve
     ```
  5. After deployment, you can view your resources in the [Azure Portal](https://portal.azure.com/).
  6. **Ask GitHub Copilot Chat**:  
     - "What files do I need for a basic Terraform project?"  
     - "How do I use Terraform to deploy an Azure Storage Account?"  
     - "How do I destroy resources created by Terraform?"

- **Bicep Example (Best Practices):**
  1. Create a subfolder named `bicep-demo` in your project directory and open it in VSCode.
  2. Inside `bicep-demo`, create a file named `main.bicep` and paste the following code:
     ```bicep
     resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
       name: 'examplestorageacct'
       location: 'East US'
       sku: {
         name: 'Standard_LRS'
       }
       kind: 'StorageV2'
     }
     ```
  3. Open a terminal in VSCode, navigate to the `bicep-demo` folder, and run:
     ```bash
     az group create --name example-rg --location "East US"
     az deployment group what-if --resource-group example-rg --template-file main.bicep
     az deployment group create --resource-group example-rg --template-file main.bicep
     ```
  4. After deployment, you can view your resources in the [Azure Portal](https://portal.azure.com/).
  5. **Ask GitHub Copilot Chat**:  
     - "How do I deploy a Bicep template using Azure CLI?"  
     - "How do I parameterize a Bicep template?"

> **Azure Best Practice:** Always use variables and outputs for reusability, validate your templates before deployment, and never hardcode sensitive values. For more, see [Azure Best Practices](https://learn.microsoft.com/en-us/azure/architecture/best-practices/) and [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/style).

---

### 4. Using GitHub Copilot and Copilot Chat
- **Resources**:
  - [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- **Hands-On**:
  1. Enable GitHub Copilot in VSCode.
  2. Use Copilot to generate Terraform and Bicep templates.
  3. Experiment with prompts like:
     - "Create a Terraform script to deploy an Azure Virtual Machine."
     - "Write a Bicep template for an Azure App Service."
  4. **Ask GitHub Copilot Chat**:  
     - "How do I enable GitHub Copilot in VSCode?"  
     - "What are some best practices for using GitHub Copilot with Terraform?"

---

### 5. Collaborating with GitHub
- **Resources**:
  - [GitHub Docs: Branches](https://docs.github.com/en/get-started/quickstart/github-flow)
- **Hands-On**:
  1. Create a new branch:
     ```bash
     git checkout -b feature-branch
     ```
  2. Push the branch to GitHub:
     ```bash
     git push origin feature-branch
     ```
  3. Open a pull request in GitHub and merge it.
  4. **Ask GitHub Copilot Chat**:  
     - "How do I create a pull request in GitHub?"  
     - "What is the best way to resolve merge conflicts?"

---

## Additional Resources
- [VSCode Docs](https://code.visualstudio.com/docs)
- [Azure Resource Manager Templates](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/)

---

## Next Steps
1. Share this training plan with participants.
2. Schedule a live session or provide pre-recorded videos for each section.
3. Provide a GitHub repository with starter code for Terraform and Bicep examples.

