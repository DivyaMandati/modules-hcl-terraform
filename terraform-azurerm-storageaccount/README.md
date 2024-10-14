# Introduction
- Managing resources in Azure efficiently often requires using a storage account with standardized naming conventions.
- This Terraform module helps in automating the creation of an Azure Storage Account with a consistent naming pattern.
- By using this module, you can ensure that your storage accounts are named correctly based on the environment, project, and region.
- This module is designed to be integrated easily into your CI/CD pipelines, making it simple to manage your infrastructure as code.

# What is an Azure Storage Account?

- An Azure Storage Account is a fundamental resource in Microsoft Azure that provides a unique namespace in which you can store and access your data objects. Azure Storage offers highly available, massively scalable, durable, and secure storage for a variety of data objects. Azure Storage supports multiple data types and services, including:

`Blob Storage` : Optimized for storing massive amounts of unstructured data, such as text or binary data.

`File Storage` : Provides managed file shares in the cloud that can be accessed via the SMB protocol.

`Queue Storage` : Enables reliable messaging between application components.

`Table Storage` : Stores structured NoSQL data in the cloud, providing a key/attribute store with a schema-less design.

`Disk Storage` : Provides persistent, durable, and high-performance storage for Azure virtual machines.

# Azure Storage Account Module

This is the Terraform script to create a Storage Account using modules, which provides a flexible way to set its name based on specified variables.

# Folder structure 
```
├── README.md
├── main.tf
├── locals.tf
├── outputs.tf
├── variables.tf
│     
└── test
    ├── main.tf
    ├── variables.tf
    └── versions.tf

```

# Usage 
1. `Initialize Terraform` : Navigate to the test folder and run below command. This Initializes the terraform process.

```
terraform init
```
2. `Validate Terraform` : Navigate to the test folder and run below command. This validates our terraform code.

```
terraform validate
```
3. `Planning Terraform` : Navigate to the test folder and run below command. This gives a proper plan for resources to be created. 

```
terraform plan
```
4. `Apply Configuration` : Navigate to the test folder and run below command. Apply the configuration to create the resource group.

```
terraform apply
```