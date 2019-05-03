# Shared VPC and Site to Site VPNs in Google Cloud


## Overview

This code base will configure the base shared vpc, site to site vpns, and all supporting base
project definitions that are required for the networking.

### TODOs
- Determine if firewall ACLs belong here or if this is coming out of something else
- Build a better IAM story

### Project Outputs



### Network Outputs

- host_project_network
- shared_services_subnetwork


## Execution Information

Available commands
- terragrunt plan
- terragrunt apply
- terragrunt destroy

## Additional information

Creating route based vpns with gcloud this is a bit of reference information to work off of to get the terraform code
fleshed out.

``````
create on-prem-tunnel1 --peer-address ?.?.?.? \
    --target-vpn-gateway my-vpn-gateway --ike-version 2 --local-traffic-selector 0.0.0.0/0 \
    --remote-traffic-selector 0.0.0.0/0 --shared-secret=mysharedsecret --region us-central1