
# Automation with GitHub Copilot in VS Code

This training guide is designed for infrastructure Cloud solutions architects to learn how to leverage GitHub Copilot in VS Code when working with Terraform and Bicep automation technologies.

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [GitHub Copilot Modes](#github-copilot-modes)
4. [Exercises for New Users](#exercises-for-new-users)
5. [Exercises for Experienced Users](#exercises-for-experienced-users)
6. [Exercises for Expert Users](#exercises-for-expert-users)

## Introduction

GitHub Copilot is an AI-powered code completion tool that can help you write code faster and more efficiently. This guide will walk you through exercises to leverage GitHub Copilot specifically for infrastructure automation using Terraform and Azure Bicep.

## Prerequisites

- Visual Studio Code installed
- GitHub Copilot extension installed and authenticated
- Azure CLI installed
- Terraform installed
- Azure Bicep extension for VS Code installed
- An active Azure subscription

## GitHub Copilot Modes

GitHub Copilot offers two primary modes of interaction:

### Edit Mode
- Inline code suggestions as you type
- Tab to accept suggestions
- Works directly in your editor

### Agent Mode (Chat)
- Interactive chat interface within VS Code
- Ask questions and get code samples
- Access via the Copilot chat panel (Ctrl+Shift+I or Cmd+Shift+I)

## Exercises for New Users

### Exercise 1: Creating Your First Resource

#### Terraform Implementation
1. Open VS Code and create a new file named `main.tf`
2. Type the following comment and let Copilot suggest the code:
   ```terraform
   # Create an Azure resource group
   ```
3. Press Tab to accept the suggestion or continue typing to get more context-aware suggestions
4. Try adding another comment:
   ```terraform
   # Add a storage account in the resource group
   ```
5. Use Copilot Chat (Agent mode) by pressing Ctrl+Shift+I and asking:
   ```
   How do I add tags to all resources in this Terraform configuration?
   ```

#### Bicep Implementation
1. Open VS Code and create a new file named `main.bicep`
2. Type the following comment and let Copilot suggest the code:
   ```bicep
   // Create an Azure resource group
   ```
3. Press Tab to accept the suggestion or continue typing
4. Try adding another comment:
   ```bicep
   // Add a storage account in the resource group
   ```
5. Use Copilot Chat and ask:
   ```
   How do I add tags to all resources in this Bicep file?
   ```

### Exercise 2: Variable and Parameter Management

#### Terraform Implementation
1. Create a new file named `variables.tf`
2. Type the following comment:
   ```terraform
   # Define variables for resource group name, location, and environment
   ```
3. Accept Copilot's suggestions or modify as needed
4. In your `main.tf`, add:
   ```terraform
   # Use the variables defined in variables.tf for the resource group
   ```
5. Use Copilot Chat to ask:
   ```
   How do I create a locals block to format resource names consistently?
   ```

#### Bicep Implementation
1. In your `main.bicep` file, add:
   ```bicep
   // Define parameters for resource group name, location, and environment
   ```
2. Accept Copilot's suggestions for parameter definitions
3. Add:
   ```bicep
   // Use the parameters for the resource group
   ```
4. Use Copilot Chat to ask:
   ```
   How do I use parameter decorators to set constraints in Bicep?
   ```

### Exercise 3: Output Management

#### Terraform Implementation
1. Create a new file named `outputs.tf`
2. Type:
   ```terraform
   # Output the resource group id and storage account primary endpoint
   ```
3. Accept or modify Copilot's suggestions
4. Use Copilot Chat to ask:
   ```
   How do I format terraform outputs to be more readable?
   ```

#### Bicep Implementation
1. In your `main.bicep` file, add:
   ```bicep
   // Output the resource group id and storage account primary endpoint
   ```
2. Accept or modify Copilot's suggestions
3. Use Copilot Chat to ask:
   ```
   How do I reference outputs from one Bicep file in another?
   ```

## Exercises for Experienced Users

### Exercise 1: Multi-Resource Deployment

#### Terraform Implementation
1. Create a new file named `network.tf`
2. Type:
   ```terraform
   # Create a virtual network with 3 subnets: web, app, and database
   ```
3. Let Copilot generate the network configuration
4. In `main.tf`, add:
   ```terraform
   # Create a web app that uses the web subnet
   ```
5. Use Copilot Chat to ask:
   ```
   How do I implement network security groups with best practices for these subnets?
   ```

#### Bicep Implementation
1. Create a new file named `network.bicep`
2. Type:
   ```bicep
   // Create a virtual network with 3 subnets: web, app, and database
   ```
3. Let Copilot generate the network configuration
4. Create a `webapp.bicep` file and add:
   ```bicep
   // Create a web app that uses the web subnet
   ```
5. Use Copilot Chat to ask:
   ```
   How do I create a Bicep module for reusable network security groups?
   ```

### Exercise 2: Conditional Resources

#### Terraform Implementation
1. In `variables.tf`, add:
   ```terraform
   # Add a boolean variable to control creation of disaster recovery resources
   ```
2. In `main.tf`, add:
   ```terraform
   # Create disaster recovery storage account only if DR is enabled
   ```
3. Use Copilot Chat to ask:
   ```
   How do I use count vs for_each for conditional resource creation in Terraform?
   ```

#### Bicep Implementation
1. In `main.bicep`, add:
   ```bicep
   // Add a boolean parameter to control creation of disaster recovery resources
   ```
2. Add:
   ```bicep
   // Create disaster recovery storage account only if DR is enabled
   ```
3. Use Copilot Chat to ask:
   ```
   What are the different ways to implement conditional resources in Bicep?
   ```

### Exercise 3: Resource Configuration with Logic

#### Terraform Implementation
1. Create a file named `locals.tf`
2. Type:
   ```terraform
   # Create a local variable that builds a map of environments to SKU sizes
   ```
3. In `main.tf`, add:
   ```terraform
   # Use the environment to SKU mapping to set the appropriate size for resources
   ```
4. Use Copilot Chat to ask:
   ```
   How can I improve this logic to handle multiple regions with different SKUs for each?
   ```

#### Bicep Implementation
1. In `main.bicep`, add:
   ```bicep
   // Create a variable that builds a map of environments to SKU sizes
   ```
2. Add:
   ```bicep
   // Use the environment to SKU mapping to set the appropriate size for resources
   ```
3. Use Copilot Chat to ask:
   ```
   How can I create more advanced conditional logic in Bicep modules?
   ```

## Exercises for Expert Users

### Exercise 1: Custom Module Development

#### Terraform Implementation
1. Create a folder named `modules` and inside it a subfolder named `secure-webapp`
2. Create a `main.tf` file inside this module folder
3. Type:
   ```terraform
   # Create a secure web application module with app service, key vault, and managed identity
   ```
4. Create the required `variables.tf` and `outputs.tf` files for the module
5. In your root `main.tf`, add:
   ```terraform
   # Use the secure-webapp module with different configurations for dev and prod
   ```
6. Use Copilot Chat to ask:
   ```
   How do I implement feature flags for modules using Terraform 1.3+ optional attributes?
   ```

#### Bicep Implementation
1. Create a file named `secure-webapp.bicep`
2. Type:
   ```bicep
   // Create a secure web application module with app service, key vault, and managed identity
   ```
3. In your `main.bicep`, add:
   ```bicep
   // Use the secure-webapp module with different configurations for dev and prod
   ```
4. Use Copilot Chat to ask:
   ```
   How do I implement feature flags for modules using Bicep user-defined types?
   ```

### Exercise 2: Testing Infrastructure Code

#### Terraform Implementation
1. Create a folder named `tests`
2. Inside, create a file named `main_test.go` for Terratest
3. Type:
   ```go
   // Write a Terratest test that verifies our infrastructure
   ```
4. Use Copilot Chat to ask:
   ```
   How can I use Terratest to validate that my Azure resources have the correct network configurations?
   ```

#### Bicep Implementation
1. Create a file named `validate.azcli` or `validate.ps1`
2. Type:
   ```
   # Write a script to validate the Bicep template before deployment
   ```
3. Use Copilot Chat to ask:
   ```
   What's the best way to implement unit tests for Bicep templates?
   ```

### Exercise 3: Advanced Multi-Environment Pipeline

#### Terraform Implementation
1. Create a `.github/workflows` folder
2. Inside, create a file named `terraform-pipeline.yml`
3. Type:
   ```yaml
   # Create a GitHub Actions workflow for Terraform with plan and apply stages
   ```
4. Let Copilot generate a CI/CD pipeline
5. Use Copilot Chat to ask:
   ```
   How do I implement advanced Terraform state management techniques across multiple environments?
   ```

#### Bicep Implementation
1. Create a `.github/workflows` folder
2. Inside, create a file named `bicep-pipeline.yml`
3. Type:
   ```yaml
   # Create a GitHub Actions workflow for Bicep deployments
   ```
4. Let Copilot generate a CI/CD pipeline
5. Use Copilot Chat to ask:
   ```
   How do I implement advanced Bicep template validation and testing in my CI/CD pipeline?
   ```

## Azure Best Practices

When working with Azure resources through Terraform or Bicep, consider these best practices:

### Resource Organization
- Use resource groups to organize related resources
- Use consistent naming conventions with prefixes/suffixes
- Apply tags for governance, cost management, and operations

### Security
- Use managed identities instead of service principals when possible
- Store secrets in Azure Key Vault and reference them securely
- Implement least-privilege access for resources
- Enable diagnostic settings for audit and monitoring

### Performance and Cost
- Choose the appropriate SKUs for your workload
- Use autoscaling where applicable
- Implement resource locks for critical resources
- Consider Azure reservations for cost optimization

### Deployment
- Use what-if operations (terraform plan/az deployment what-if) before applying changes
- Implement CI/CD pipelines for infrastructure changes
- Use state management strategies (remote state for Terraform)
- Implement modular templates for reusability

## Tips for Getting the Most Out of GitHub Copilot

1. **Be specific in your comments**: The more context you provide, the better suggestions you'll get.

2. **Iterate with comments**: If you don't get the code you want initially, add more comments to guide Copilot.

3. **Use Chat for complex queries**: When you need explanations or complex solutions, switch to Chat mode.

4. **Learn from Copilot**: Review the suggested code to learn best practices and new techniques.

5. **Verify generated code**: Always review and test code generated by Copilot before using it in production.

## Next Steps

After completing these exercises, try creating a complete infrastructure project combining multiple resources and using both Terraform and Bicep to understand which tool works best for your specific scenarios.
