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
ssh [private-IP-of-Client]
#Example: ssh 192.168.1.2
```
