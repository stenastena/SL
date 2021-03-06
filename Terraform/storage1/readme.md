# Blob storage with blob example (this option is better for manual executing in console for first testing)

## Prerequisites
These actions have to be done in your machine where Terraform scripts will be performed

1. Install Azure CLI
2. Install Terraform 

## Deploy Azure resources from console with Azure CLI and Terraform

Download script's directory from the github"
https://github.com/stenastena/SL 
and unzip it in a target directory.

Go to the target directory.
```
$ cd your_target_directory/storage1
```
## Part 1. Connect to Azure
Login to the Azure CLI using:

``` 
$ az login 
```

Once logged in - it's possible to list the Subscriptions associated with the account via:

```
$ az account list
```

The output (similar to below) will display one or more Subscriptions - with the id field being the subscription_id field referenced above.

```
[
  {
    "cloudName": "AzureCloud",
    "id": "00000000-0000-0000-0000-000000000000",
    "isDefault": true,
    "name": "PAYG Subscription",
    "state": "Enabled",
    "tenantId": "00000000-0000-0000-0000-000000000000",
    "user": {
      "name": "user@example.com",
      "type": "user"
    }
  }
]
```
Should you have more than one Subscription, you can specify the Subscription to use via the following command:

```
$ az account set --subscription="SUBSCRIPTION_ID"
```
## Part 2. Configure your future resource group and properties of storage account
*Change your configuration parts in the file variables.tf*
* Prefix for all your future components. It also will be used in resource group name.
* Location of Azure datacenter
* Tags 

## Part 3. Perform Terraform script 
Initialize Terraform only once.
```
$ terraform init
```
Run Terraform and after checking apply with "yes"
```
$ terraform apply
```
Also you can perform Terraform with automatic enforcement
```
$ terraform apply -auto-approve
```
## Delete resources
It is mandatory to run the Terraform script from the folder from which the resources were deployed. 
```
$ terraform destroy
```
