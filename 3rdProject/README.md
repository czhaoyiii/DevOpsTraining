## 3rd Project (Installing packages to other EC2 using Ansible)
I will be using the EC2 instances created in the 2nd Project

And using the Server instance to install packages to the Client instances

### Configurations:
1. Update the packages in Server instance (Good Practice)
```
sudo apt update
sudo apt upgrade
```
2. Install Ansible in Server instance
```
sudo apt install ansible
```
### Passwordless SSH Authentication:
1. Generate the public key in Server instance
```
ssh-keygen
```
2. Copy the public key of the Server instance
```
cat ~/.ssh/id_rsa.pub
```
```
#This is the public key of the Server instance
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABg/W11jGKNKocxO3Fp84A7LIEF1NlHEOxnZ2UAekMmv/2093hoaxzwTf6P/E74QzVmrzd5ScxS6wAbgXLZ+47sG2PJkwJ/JXWm6A0vUT84b/c9xCOO7SZeu1y/KNdlQTMuMrMRBd2vplZiUWb0oRj+Py2rZq+dsdadasdasdasdasdgC8+QTsu4w8OLu51JvLdlrWCyP5cFZKxcglc42G4MXzSPDNCtsidUBtpyk61Jhd3bjy6mGWLkddit39jadsd0DkOc4aGVzUQRfi0/c6QuvLV/5P4vVGq/N75FA+z384tZ4owY75JaQkN9K49KnE7tNexgvbcz84QdqV33b3yxHSzcCpggsUjt2889qC/NeympNqsvI0bv8s5BTkjOOoFMCLNtmgUHQ253QPmQ4t10GQtOcaXa3GmuIVjst0uOKx+DO0RSkuSAmBRbE1VRDqfGNMBDExPc= ubuntu@ip-xxx-xx-x-xxx
```
3. Paste the copied public key to the Client instance authorized keys

   (If your authorized_keys have a key, paste the public key in a new line)
```
#This is the key that was generated with the instance, it is used to ssh into the instance.
ssh-rsa example-key-:D

#This is the key that was copied from the Server instance
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABg/W11jGKNKocxO3Fp84A7LIEF1NlHEOxnZ2UAekMmv/2093hoaxzwTf6P/E74QzVmrzd5ScxS6wAbgXLZ+47sG2PJkwJ/JXWm6A0vUT84b/c9xCOO7SZeu1y/KNdlQTMuMrMRBd2vplZiUWb0oRj+Py2rZq+dsdadasdasdasdasdgC8+QTsu4w8OLu51JvLdlrWCyP5cFZKxcglc42G4MXzSPDNCtsidUBtpyk61Jhd3bjy6mGWLkddit39jadsd0DkOc4aGVzUQRfi0/c6QuvLV/5P4vVGq/N75FA+z384tZ4owY75JaQkN9K49KnE7tNexgvbcz84QdqV33b3yxHSzcCpggsUjt2889qC/NeympNqsvI0bv8s5BTkjOOoFMCLNtmgUHQ253QPmQ4t10GQtOcaXa3GmuIVjst0uOKx+DO0RSkuSAmBRbE1VRDqfGNMBDExPc= ubuntu@ip-xxx-xx-x-xxx
```
4. Login to the Client instance using the Client private IP address through the Server instance
```
#Example: ssh 192.168.1.2
ssh [private-IP-of-Client]
```
### Create/Install/Start stuff to Client instances using Server instance:
1. Create a file named "inventory" and fill it with the Client IP address (I have 2 Client)
```
vim inventory
```
```
172.31.91.245
172.31.83.9
```
2. In the Server instance, using Ansible Adhoc Commands. create a simple file named "testing"
```
ansible -i inventory all -m "shell" -a "touch testing"
```
Both my Client instances have a file named testing.

3. In the Server instance, I will create a yaml file, playbook, to install nginx and start nginx
```
vim InS_nginx.yml
```
```
```
