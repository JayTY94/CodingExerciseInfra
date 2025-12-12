# Getting started

Run the following:

```
az login
terraform init
terraform plan
```

Everything should still be working if you're running it on your work machine. Run terraform apply to put up the virtual machine.
Because of how I set things up, the ephemeral module renames everything each time it's run (or terraform rethinks it does. this doesn't create a net change until the next day.), so terraform will tear down the entire module and rebuild it each time. This may actually be a good thing. Just make sure not to apply again if you have any workflow running on the VM.

```
terraform apply
```



# Tearing down

Run the following command to tear down the VM, saving costs.

```
terraform destroy --target=modules.ephemeral
```