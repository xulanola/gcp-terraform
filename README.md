# eHarmony Terraform Infrastructure Code

**References**
- https://github.com/steinim/gcp-terraform-workshop
- https://www.terraform.io/docs/providers/google/index.html

**Tooling**
- Terraform
- Terragrunt
- test-kitchen
- bats

## GCP Project Notes
These are the projects that are allocated to the eHarmony environment



terraform-admin is the project with the service account that we will use for all the terraform operations.

**Notes** All shared VPC host projects need to be staged and manually derived in the the environment tfvars files. 

 Reference the `test.tfvars` envars file for a reference

## Rules of the Road

**Being a good Citizen**
- When you see something that needs to be fixed, fix it, if you can't, add a `@TODO` with ample information to come back and fix it
- When fixing a `@TODO` remove the `@TODO` so the codebase is clean
- All folders should have a `README.md` explaining the nature of what the code is supposed to be doing
- Be friendly to the people that are coming into the codebase, comment your code.

**Terraform**
- You will need to source the environment `.env` files into your shell be executing `source envars/<environment>.env` to put you in to the proper environment execution
- Working locally it's assumed that you have your `GOOGLE_APPLICATION_CREDENTIALS` envar exported properly
- All applications must leverage Terragrunt for locking
- Leverage `terraform validate` before committing to make sure your code is good
- Try to make sure anything that can be pulled into variable is pulled into it
- Folder Layout
  * Persistent = parts of the application stack that have persistence tied to them ie Database servers
  * Ephemeral = parts of the application stack that can be blown away ie webservers / k8s compute nodes
- If your code is not ready for terragrunt runs name your `terraform.tfvars` to `terraform.tfvars.skip`
- Using snakes `_` vs kebab `-` : for variable names use snake but for values inside of the variable use kebab. E.g:
```
GOOD....
project_name       = {
  "shared-vpc"      = "shared-vpc-host-project"
}

BAD...
project_name       = {
  "shared_vpc"      = "shared-vpc-host-project"
}
```

Snakes must be used for resource names as well, an example is shown below:
```
GOOD...
module "db_server" {
  source                     = "../../../../modules/vault-db-server"
  project_name               = "${var.project_name["vault"]}"
  [...]
}

BAD...
module "db-server" {
  source                     = "../../../../modules/vault-db-server"
  project_name               = "${var.project_name["vault"]}"
  [...]
}
```
```
GOOD...
resource "google_project_iam_binding" "iamserviceAccountActor_shared_vpc" {
  [...]
}

BAD...
resource "google_project_iam_binding" "iamserviceAccountActor-shared-vpc" {
  [...]
}
```

Troubleshooting

```$xslt
* google_project.host_project: 1 error(s) occurred:

* google_project.host_project: google_project.host_project: Error reading billing account for project "projects/corp-ck-admin-29a53a5ea134c621": googleapi: Error 403: Google Cloud Billing API has not been used in project ck-corp-admin before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/cloudbilling.googleapis.com/overview?project=ck-corp-admin then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry., accessNotConfigured
* google_project.vault_project: 1 error(s) occurred:

```
- Resolution is to make sure that you have the billing api enabled in your project services

```
Error: Error applying plan:

1 error(s) occurred:

* google_compute_network.cloud_rack_bridge_vpc: 1 error(s) occurred:

* google_compute_network.cloud_rack_bridge_vpc: Error creating network: googleapi: Error 403: Project 152827260138 is not found and cannot be used for API calls. If it is recently created, enable Compute Engine API by visiting https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=152827260138 then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry., accessNotConfigured


```
- You will need to re-run terraform apply, this is due to projects being eventually consistently available upon creation in the api


```
Initializing the backend...

Error configuring the backend "gcs": Error parsing credentials 'default': invalid character 'd' looking for beginning of value

Please update the configuration in your Terraform files to fix this error
then run this command again.
```
- Make sure that your GOOGLE_APPLICATION_CREDENTIALS is set in your environment variables

## Pending Issues
- When tearing and recreating a project you may run into a propagation issue where GCP console will state that the resource is 
ready for deletion when it's not.
- We need to have higher quota limit or a way to purge projects, especially when we are iterating fast on Terraform: `google_project.shared_services_project: Error code 8, message: projects created quota exceeded`
- Sometimes when creating new `projects` with `networks`, terraform will error out due to eventual consistency of the project creation you may have to re-run terraform apply a second time.
- Right now we don't have a way to get away from static service account credential files, looking into this from a Vault perspective
- Currently when creating accounts and addressing multi role IAM policies currently you have to do individual blocks per `role` instead of being able to provide a list of roles that need to be applied to a common set of users
- Currently right now attaching a service account to an instance is not working.
- CloudDNS Module doesn't work in the Staging environment.
- Modules with delineation between windows and linux are colliding, currently there is no platform notation in the naming structure. temp fix was implemented to append `w-` for windows nodes.

## Onboarding 



