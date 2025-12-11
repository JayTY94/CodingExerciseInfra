# Getting started

Run the following:

```
az login
terraform init
terraform plan
```

Everything should still be working if you're running it on your work machine. Run terraform apply to put up the virtual machine.

```
terraform apply
```



# Tearing down

Run the following command to tear down the VM, saving costs.

```
terraform destroy --target=modules.ephemeral
```