# The Weather Exporter
This is a sample project that serves as an example of how to combine different devops tools.
1. **Python**; The exporter is written in python and does a get request to api.weatherapi.com to grab the current weather of a city of your choosing.
2. **Docker**; We package this exporter using docker and create an image that is then pushed to githubs container registry.
3. **Terraform**; The infrastructure is provisioned using the azurerm terraform provider and creates a resource grup, vnet, subnet, nic, nsg, and a vm.
4. **Ansible**; In order to install docker in the Azure VM and to deploy the docker containers we use ansible.

**TODO**
Create a github actions pipeline that rebuilds and pushes the image to the container registry everytime a change is made to the source code.

# Step-by-Step deployment guide
## Requirements
1. You first need an account in azure cloud.
2. You need to download the Azure cli; https://learn.microsoft.com/en-us/cli/azure/?view=azure-cli-latest
4. You need terraform; https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
5. You need ansible; https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
6. You will need to make an account and generate an api-token here https://www.weatherapi.com/.
7. You will need an SSH keypair; `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""`

## Deploy the VM
1. Before you can run terraform you first need to login to azure from your terminal. Run the following command `az login`
2. Add your subscription ID as an env variable; `export TF_VAR_subscription_id=$(az account show --query id -o tsv)`
3. Now you can deploy. Go to the terraform directory and run apply; `terraform apply`

## Deploy the applications
1. Before you run ansible you need to find out what the public IP of your VM is; `az vm list-ip-addresses --name lab-vm --resource-group lab-resource-group --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" --output tsv`
2. Go to the ansible directory and create a file called `.env`and add the variables `CITY`and `KEY` to the file. Should look something like this: 
```
CITY="Tallinn"
KEY="123456789"
```
3. Now you can run ansible; `ansible-playbook -i <Public_IP_of_your_VM>, main.yml`
