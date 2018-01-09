# terraform_simple

The project creates basic aws infrastructure with using Terraform. 
It will create two layers (private-public) infrastructure in a new vpc. 
It creates an Aurora Db cluster in private zone and an ASG in public zone.  
Docker engine is installed on the ec2 machines as default.

Before create the infrastructure, you should create key-pairs in a folder named "keys". 
The "keys" folder must be placed at the same level of the main project folder. 
The key should be named as "universalkey". 
These settings can be changed in vars.tf file.






