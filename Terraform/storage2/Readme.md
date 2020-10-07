# Blob storage with blob example

## Prerequisites
These actions have to be done in your machine where Terraform scripts will be performed

1. Install Azure CLI
2. Install Terraform 

## Deploy Azure resources with Azure CLI and Terraform with Azure service principal

Download script's directory from the github"
https://github.com/stenastena/SL 
and unzip it in a target directory.

Go to the target directory.
```
$ cd your_target_directory/Storage2
```
## Part 1 Configure Azure service principal (it will be done onle once)
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

We can now create the Service Principal which will have permissions to manage resources in the specified Subscription using the following command:

```
$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```
This command will output 5 values
 ```
 {
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```
These values map to the Terraform variables like so:

`appId` is the `client_id` defined above.

`password` is the `client_secret` defined above.

`tenant` is the `tenant_id` defined above.

*Write down `client_secret` in secure place and use it further in command line when you will execute Terraform script*  

### Part 2 Configurate your future resource group and properties of storage account
*Change your basic configuration parts in the file variables.tf*
* Prefix for all your future components
* Location of Azure datacenter
* Tags 

*Change or add storage properties in block resource "azurerm_storage_account".*

*with  using this reference https://www.terraform.io/docs/providers/azurerm/r/storage_blob.html*

## Part 3 Perform Terraform script

Perform Terraform script
```
$ terraform apply -auto-approve -var="client_secret=XXXXXXXXXXXXXXXXXXXX"
```


