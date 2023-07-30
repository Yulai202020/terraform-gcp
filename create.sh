terraform init 
terraform plan --auto-approve # create plan
terraform apply --auto-approve # apply datas

### terraform [options] --auto-approve # auto yes
### terraform validate # check all .tf files
### terraform fmt # format all file .tf
### terraform destroy --auto-approve # destroy all what created apply command
### terraform taint [resource name] # plan only [resource name]