# Automation with GitHub Copilot in VS Code

This training guide is designed for infrastructure Cloud solutions architects to learn how to leverage GitHub Copilot in VS Code when working with Terraform and Bicep automation technologies.

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [GitHub Copilot Commands and Modes](#github-copilot-commands-and-modes)
4. [Exercises for New Users](#exercises-for-new-users)
5. [Exercises for Experienced Users](#exercises-for-experienced-users)
6. [Exercises for Expert Users](#exercises-for-expert-users)
7. [GitHub Copilot for Azure Exercise](#github-copilot-for-azure-exercise)
8. [Azure Best Practices](#azure-best-practices)
9. [Tips for Getting the Most Out of GitHub Copilot](#tips-for-getting-the-most-out-of-github-copilot)
10. [Next Steps](#next-steps)

## Introduction

GitHub Copilot is an AI-powered code completion tool that can help you write code faster and more efficiently. This guide will walk you through exercises to leverage GitHub Copilot specifically for infrastructure automation using Terraform and Azure Bicep.

## Prerequisites

- Visual Studio Code installed
- GitHub Copilot extension installed and authenticated
- Azure CLI installed
- Terraform installed
- Azure Bicep extension for VS Code installed
- An active Azure subscription

## GitHub Copilot Commands and Modes

GitHub Copilot offers different types of interactions for different purposes:

### Copilot "Ask" Commands (Questions & Explanations)

Use these for learning, understanding, and getting explanations:

- **Ask questions** about concepts, best practices, and troubleshooting
- **Get explanations** of existing code or infrastructure patterns
- **Request documentation** and examples
- Access via the Copilot chat panel (Ctrl+Shift+I or Cmd+Shift+I)
- Start with phrases like "How do I...", "What is...", "Explain...", "Why..."

### Copilot "Agent" Commands (Actions & Code Generation)

Use these for creating, modifying, and generating content:

- **Generate code** and infrastructure templates
- **Create files** and project structures
- **Modify existing code** and configurations
- **Build complete solutions** from scratch
- Access via the Copilot chat panel with action-oriented prompts
- Start with phrases like "Create...", "Generate...", "Build...", "Implement..."

### Inline Suggestions (Edit Mode)

- Real-time code completion as you type
- Tab to accept suggestions
- Works directly in your editor with comments to guide suggestions

## Exercises for New Users

### Exercise 1: Creating Your First Resource

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

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

**Using Copilot Ask Commands (Questions):**

5. Use Copilot Chat (Ctrl+Shift+I or Cmd+Shift+I) and ask:

   ```text
   How do I add tags to all resources in this Terraform configuration?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

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

**Using Copilot Ask Commands (Questions):**

5. Use Copilot Chat and ask:

   ```text
   How do I add tags to all resources in this Bicep file?
   ```

### Exercise 2: Variable and Parameter Management

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

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

**Using Copilot Ask Commands (Questions):**

5. Use Copilot Chat to ask:

   ```text
   How do I create a locals block to format resource names consistently?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

1. In your `main.bicep` file, add:

   ```bicep
   // Define parameters for resource group name, location, and environment
   ```

2. Accept Copilot's suggestions for parameter definitions
3. Add:

   ```bicep
   // Use the parameters for the resource group
   ```

**Using Copilot Ask Commands (Questions):**

4. Use Copilot Chat to ask:

   ```text
   How do I use parameter decorators to set constraints in Bicep?
   ```

### Exercise 3: Output Management

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

1. Create a new file named `outputs.tf`
2. Type:

   ```terraform
   # Output the resource group id and storage account primary endpoint
   ```

3. Accept or modify Copilot's suggestions

**Using Copilot Ask Commands (Questions):**

4. Use Copilot Chat to ask:

   ```text
   How do I format terraform outputs to be more readable?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

1. In your `main.bicep` file, add:

   ```bicep
   // Output the resource group id and storage account primary endpoint
   ```

2. Accept or modify Copilot's suggestions

**Using Copilot Ask Commands (Questions):**

3. Use Copilot Chat to ask:

   ```text
   How do I reference outputs from one Bicep file in another?
   ```

**Additional Agent Mode Practice:**

4. Use Copilot Agent to generate a complete validation script. In Copilot Chat, type:

   ```text
   Generate a PowerShell script that validates the Bicep template and deploys it to Azure
   ```

5. Create a new file called `deploy.ps1` and use Agent mode to generate:

   ```text
   Create a deployment script that checks prerequisites, validates the template, and handles errors
   ```

## Exercises for Experienced Users

### Exercise 1: Multi-Resource Deployment

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

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

**Using Copilot Ask Commands (Questions):**

5. Use Copilot Chat to ask:

   ```text
   How do I implement network security groups with best practices for these subnets?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

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

**Using Copilot Ask Commands (Questions):**

5. Use Copilot Chat to ask:

   ```text
   How do I create a Bicep module for reusable network security groups?
   ```

**Additional Agent Mode Practice:**

6. Use Agent mode to generate comprehensive networking components. In Copilot Chat, type:

   ```text
   Generate a complete Bicep module that creates a virtual network with subnets, NSGs, and route tables for a 3-tier architecture
   ```

7. Create a new file `monitoring.bicep` and use Agent mode:

   ```text
   Create Bicep code that adds Application Insights and Log Analytics workspace for monitoring the web application
   ```

### Exercise 2: Conditional Resources

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

1. In `variables.tf`, add:

   ```terraform
   # Add a boolean variable to control creation of disaster recovery resources
   ```

2. In `main.tf`, add:

   ```terraform
   # Create disaster recovery storage account only if DR is enabled
   ```

**Using Copilot Ask Commands (Questions):**

3. Use Copilot Chat to ask:

   ```text
   How do I use count vs for_each for conditional resource creation in Terraform?
   ```

**Additional Agent Mode Practice:**

4. Use Agent mode to generate advanced conditional logic. In Copilot Chat, type:

   ```text
   Create a Terraform configuration that conditionally deploys different resource types based on environment variables and region
   ```

5. Generate data source usage examples:

   ```text
   Generate Terraform code that uses data sources to fetch existing resources and conditionally create new ones based on those findings
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

1. In `main.bicep`, add:

   ```bicep
   // Add a boolean parameter to control creation of disaster recovery resources
   ```

2. Add:

   ```bicep
   // Create disaster recovery storage account only if DR is enabled
   ```

**Using Copilot Ask Commands (Questions):**

3. Use Copilot Chat to ask:

   ```text
   What are the different ways to implement conditional resources in Bicep?
   ```

### Exercise 3: Resource Configuration with Logic

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

1. Create a file named `locals.tf`
2. Type:

   ```terraform
   # Create a local variable that builds a map of environments to SKU sizes
   ```

3. In `main.tf`, add:

   ```terraform
   # Use the environment to SKU mapping to set the appropriate size for resources
   ```

**Using Copilot Ask Commands (Questions):**

4. Use Copilot Chat to ask:

   ```text
   How can I improve this logic to handle multiple regions with different SKUs for each?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

1. In `main.bicep`, add:

   ```bicep
   // Create a variable that builds a map of environments to SKU sizes
   ```

2. Add:

   ```bicep
   // Use the environment to SKU mapping to set the appropriate size for resources
   ```

**Using Copilot Ask Commands (Questions):**

3. Use Copilot Chat to ask:

   ```text
   How can I create more advanced conditional logic in Bicep modules?
   ```

## Exercises for Expert Users

### Exercise 1: Custom Module Development

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

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

**Using Copilot Ask Commands (Questions):**

6. Use Copilot Chat to ask:

   ```text
   How do I implement feature flags for modules using Terraform 1.3+ optional attributes?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

1. Create a file named `secure-webapp.bicep`
2. Type:

   ```bicep
   // Create a secure web application module with app service, key vault, and managed identity
   ```

3. In your `main.bicep`, add:

   ```bicep
   // Use the secure-webapp module with different configurations for dev and prod
   ```

**Using Copilot Ask Commands (Questions):**

4. Use Copilot Chat to ask:

   ```text
   How do I implement feature flags for modules using Bicep user-defined types?
   ```

### Exercise 2: Testing Infrastructure Code

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

1. Create a folder named `tests`
2. Inside, create a file named `main_test.go` for Terratest
3. Type:

   ```go
   // Write a Terratest test that verifies our infrastructure
   ```

**Using Copilot Ask Commands (Questions):**

4. Use Copilot Chat to ask:

   ```text
   How can I use Terratest to validate that my Azure resources have the correct network configurations?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

1. Create a file named `validate.azcli` or `validate.ps1`
2. Type:

   ```shell
   # Write a script to validate the Bicep template before deployment
   ```

**Using Copilot Ask Commands (Questions):**

3. Use Copilot Chat to ask:

   ```text
   What's the best way to implement unit tests for Bicep templates?
   ```

### Exercise 3: Advanced Multi-Environment Pipeline

#### Terraform Implementation

**Using Copilot Agent Commands (Code Generation):**

1. Create a `.github/workflows` folder
2. Inside, create a file named `terraform-pipeline.yml`
3. Type:

   ```yaml
   # Create a GitHub Actions workflow for Terraform with plan and apply stages
   ```

4. Let Copilot generate a CI/CD pipeline

**Using Copilot Ask Commands (Questions):**

5. Use Copilot Chat to ask:

   ```text
   How do I implement advanced Terraform state management techniques across multiple environments?
   ```

#### Bicep Implementation

**Using Copilot Agent Commands (Code Generation):**

1. Create a `.github/workflows` folder
2. Inside, create a file named `bicep-pipeline.yml`
3. Type:

   ```yaml
   # Create a GitHub Actions workflow for Bicep deployments
   ```

4. Let Copilot generate a CI/CD pipeline

**Using Copilot Ask Commands (Questions):**

5. Use Copilot Chat to ask:

   ```text
   How do I implement advanced Bicep template validation and testing in my CI/CD pipeline?
   ```

## GitHub Copilot for Azure Exercise

This exercise demonstrates the specific Azure capabilities within GitHub Copilot, showcasing how the integrated Azure tools can enhance your cloud development workflow.

### Prerequisites for Azure Integration

- Visual Studio Code with GitHub Copilot extension
- Azure Account extension for VS Code
- Active Azure subscription
- Azure CLI installed and authenticated

### Exercise 1: Azure Resource Discovery and Management

#### Using Copilot Ask Commands (Azure Knowledge)

**Scenario**: You need to understand your current Azure environment and plan resource deployments.

1. **Discover Azure Resources**: Use Copilot Chat to ask:

   ```text
   @azure What Azure subscriptions do I have access to?
   ```

2. **Check Resource Availability**: Ask about Azure service availability:

   ```text
   @azure What AI models are available in the West US 2 region for my subscription?
   ```

3. **Query Existing Resources**: Get information about your current resources:

   ```text
   @azure List all my virtual machines and their current status
   ```

4. **Get Architecture Guidance**: Ask for architectural recommendations:

   ```text
   @azure Help me design a 3-tier web application architecture for a healthcare application with 10,000 concurrent users
   ```

#### Using Copilot Agent Commands (Azure Actions)

**Scenario**: Deploy and configure Azure resources using integrated Azure tooling.

5. **Generate Infrastructure as Code**: Use Agent commands to create Azure resources:

   ```text
   @azure Create a Bicep template for a secure web application with App Service, Key Vault, Application Insights, and managed identity
   ```

6. **Create Deployment Scripts**: Generate Azure CLI commands for deployment:

   ```text
   @azure Generate Azure CLI commands to create a resource group and deploy my Bicep template
   ```

7. **Build Monitoring Solutions**: Create comprehensive monitoring setup:

   ```text
   @azure Create a monitoring dashboard configuration for my web application with alerts for performance and availability
   ```

### Exercise 2: Azure AI and Advanced Services Integration

#### Using Copilot Ask Commands (Learning Azure AI)

1. **Understand Azure AI Services**: Ask about available AI capabilities:

   ```text
   @azure How do I implement Azure OpenAI in my application for chat functionality?
   ```

2. **Learn about Azure Cognitive Services**: Get guidance on AI integration:

   ```text
   @azure What's the difference between Azure OpenAI and Azure Cognitive Services for text analysis?
   ```

3. **Explore Azure Container Services**: Understand containerization options:

   ```text
   @azure When should I use Azure Container Apps vs Azure Kubernetes Service vs Azure Container Instances?
   ```

#### Using Copilot Agent Commands (Implementing Azure AI)

4. **Create AI-Powered Applications**: Generate application code with Azure AI:

   ```text
   @azure Build a Python Flask application that uses Azure OpenAI for document summarization with proper authentication
   ```

5. **Implement Azure Storage Integration**: Create data management solutions:

   ```text
   @azure Create a Node.js application that uploads files to Azure Blob Storage and processes them with Azure Functions
   ```

6. **Build Container Applications**: Generate containerized solutions:

   ```text
   @azure Create a Docker containerized application and Azure Container Apps configuration for a REST API with Redis cache
   ```

### Exercise 3: Azure DevOps and Automation

#### Using Copilot Ask Commands (DevOps Best Practices)

1. **Learn CI/CD Best Practices**: Understand Azure DevOps patterns:

   ```text
   @azure What are the best practices for implementing CI/CD pipelines for Azure Container Apps?
   ```

2. **Understand Azure Security**: Get security guidance:

   ```text
   @azure How do I implement zero-trust security principles in my Azure architecture?
   ```

3. **Get Cost Optimization Advice**: Learn about cost management:

   ```text
   @azure How can I optimize costs for my multi-region Azure deployment?
   ```

#### Using Copilot Agent Commands (Automation and Deployment)

4. **Generate GitHub Actions Workflows**: Create CI/CD pipelines:

   ```text
   @azure Create a GitHub Actions workflow that builds and deploys a containerized application to Azure Container Apps with environment promotion
   ```

5. **Create Infrastructure Automation**: Build comprehensive IaC solutions:

   ```text
   @azure Generate a complete Azure deployment with Bicep that includes networking, security, monitoring, and auto-scaling for a production web application
   ```

6. **Implement Disaster Recovery**: Create backup and recovery solutions:

   ```text
   @azure Create a disaster recovery setup with automated failover between Azure regions for my web application
   ```

### Exercise 4: Real-World Scenario Integration

#### Complete Project: E-commerce Platform

**Scenario**: Build a complete e-commerce platform using Azure services with GitHub Copilot for Azure.

**Using Ask Commands for Planning:**

1. **Architecture Planning**:
   ```text
   @azure Design a scalable e-commerce architecture that handles 50,000 daily users with payment processing, inventory management, and recommendation engine
   ```

2. **Technology Selection**:
   ```text
   @azure What Azure services should I use for user authentication, product catalog, order processing, and analytics in an e-commerce platform?
   ```

**Using Agent Commands for Implementation:**

3. **Generate Infrastructure**:
   ```text
   @azure Create a complete infrastructure setup with Bicep for an e-commerce platform including databases, caching, messaging, and monitoring
   ```

4. **Build Application Components**:
   ```text
   @azure Generate microservices code for user management, product catalog, and order processing using Azure Functions and Service Bus
   ```

5. **Implement Security and Compliance**:
   ```text
   @azure Create security configurations and compliance monitoring for PCI DSS compliance in my Azure e-commerce platform
   ```

6. **Set Up Monitoring and Analytics**:
   ```text
   @azure Build comprehensive monitoring, logging, and analytics solution with Application Insights and Azure Monitor for the e-commerce platform
   ```

### Key Benefits of GitHub Copilot for Azure

#### Enhanced Productivity
- **Integrated Azure Knowledge**: Direct access to Azure-specific guidance and best practices
- **Real-time Resource Management**: Query and manage Azure resources without leaving VS Code
- **Intelligent Code Generation**: Context-aware generation of Azure-specific code and configurations

#### Improved Learning
- **Azure Best Practices**: Built-in knowledge of Azure architectural patterns and security guidelines
- **Service Integration**: Understanding of how different Azure services work together
- **Cost Optimization**: Guidance on cost-effective Azure resource configurations

#### Streamlined Development
- **Infrastructure as Code**: Advanced Bicep and ARM template generation
- **CI/CD Integration**: Automated pipeline creation for Azure deployments
- **Monitoring and Observability**: Built-in monitoring and alerting configurations

### Tips for Effective Azure Integration

1. **Use the @azure prefix**: Always include `@azure` in your prompts for Azure-specific responses
2. **Combine Ask and Agent modes**: Use Ask commands to understand concepts, then Agent commands to implement
3. **Specify your subscription context**: Mention which subscription or environment you're working with
4. **Include resource constraints**: Specify budget, region, or compliance requirements in your prompts
5. **Iterate and refine**: Use follow-up questions to refine generated solutions
6. **Validate with Azure tools**: Always verify generated configurations with Azure CLI or PowerShell

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

3. **Use Ask commands for learning**: When you need explanations or want to understand concepts, use Ask commands in Chat mode.

4. **Use Agent commands for building**: When you need to create or modify code, use Agent commands with action-oriented prompts.

5. **Learn from Copilot**: Review the suggested code to learn best practices and new techniques.

6. **Verify generated code**: Always review and test code generated by Copilot before using it in production.

## Next Steps

After completing these exercises, try creating a complete infrastructure project combining multiple resources and using both Terraform and Bicep to understand which tool works best for your specific scenarios.

### Advanced Learning Path

1. **Practice with real scenarios**: Apply these techniques to actual Azure infrastructure projects
2. **Combine Ask and Agent commands**: Use Ask commands to understand concepts, then Agent commands to implement solutions
3. **Explore advanced features**: Learn about Terraform modules, Bicep templates, and complex Azure architectures
4. **Build CI/CD pipelines**: Integrate your infrastructure code with automated deployment pipelines
5. **Share knowledge**: Teach colleagues how to effectively use GitHub Copilot for infrastructure automation
