

* terraform.tfvars

```lua
pm_vm_name      = "vm138205"   
pm_ipconfig0    = "ip=10.7.237.196/23,gw=10.7.237.1"
pm_nameserver   = "10.7.237.3"    
pm_url          = "https://10.7.237.16:8006/api2/json"
pm_token_id     = "tofu@pve!opentofu"
pm_token_secret = "4fa24fc3-bd8c-4916-ba6e-09a8aecc3b00"
sshkeys = [
  file("~/.ssh/taylor.pub"),
  file("~/.ssh/b300098957@ramena.pub")
]
```




