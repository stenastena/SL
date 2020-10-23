# Deployment of Azure resources using Terraform and Azure service principal.
These Azure services will be deployed:
* Azure storage account for blob storage
* Azure SQL Database with internal firewall rules
* Azure virtual network with private endpoint to Azure SQL DB
* Azure private DNS zone with private network link end record for private endpoint  
* Azure Container Instance (with test containter)

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
$ cd your_target_directory/ComplexSolution
```
## Part 1. Configure Azure service principal (it will be done only once)
Login to the Azure CLI using:

``` 
$ az login 
```

Once logged in - it's possible to list the Subscriptions associated with the account via:

```
$ az account list
```

The output (similar to below) will display one or more Subscriptions - with the id field being the subscription_id.

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

### Part 2. Configure your future resource group and properties of Azure service
*Change your basic configuration parts in the file `variables.tf`*
* Prefix for all your future components. It also will be used in resource group name.
* Location of Azure datacenter (`not all Azure datacenters allow to create the correct Azure SQL Database`)
* Tags
* IP addresses that have to be permited to access to Azure SQL DB
* Virtual network address space and subnet address space 

1) *Change or add storage properties in module "storage" in block resource "azurerm_storage_account" according this reference https://www.terraform.io/docs/providers/azurerm/r/storage_account.html*
2) *Change or add Azure SQL Database properties in module "azure_sql_db" in block resource "azurerm_sql_database" according this reference https://www.terraform.io/docs/providers/azurerm/r/sql_database.html*
3) *Change or add Azure Container Instaces properties in module "containerinstance" in block resource "azurerm_container_group" according this reference https://www.terraform.io/docs/providers/azurerm/r/container_group.html  
The "azurerm_container_group" module includes the deployment of a test container:*
```
container {
    name   = "nginx"
    image  = "nginx:latest"
    cpu    = "1"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
```
 *Please correct the part of container deployment in file  ```../Terraform/ComplexSolution/modules/containerinstance/main.tf``` according your needs.*

## Part 3. Perform Terraform script

Paste the real client secret that you saved earlier into command line instead XXXXXXXXXXXXXXXXXXXX and run Terraform script. 
```
$ terraform apply -auto-approve -var="client_secret=XXXXXXXXXXXXXXXXXXXX"
```

## Part 4. Delete resources
It is mandatory to run the Terraform script from the folder from which the resources were deployed.
```
$ terraform destroy -auto-approve -var="client_secret=XXXXXXXXXXXXXXXXXXXX"
```

