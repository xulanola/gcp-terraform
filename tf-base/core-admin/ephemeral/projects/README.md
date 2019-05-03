# Project Bootstrapping

## Troubleshooting

If you run into this error, the service account that you are running with had it's permissions stepped on.

Add "Project Creator" and  "Project Deleter" perms to the the service account

````aidl
1 error(s) occurred:

* module.admin.google_project.pipeline_admin: 1 error(s) occurred:

* google_project.pipeline_admin: Error creating project companyX-admin-ea022977 (companyX-admin): googleapi: Error 403: User is not authorized., forbidden.


````

## Unsolved Issues

```aidl
1 error(s) occurred:

* module.admin.google_project_iam_binding.storage_object_admin: 1 error(s) occurred:

* google_project_iam_binding.storage_object_admin: Error retrieving IAM policy for project "terraform-admin": googleapi: Error 403: The caller does not have permission, forbidden


```