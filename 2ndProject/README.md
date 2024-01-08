## 2nd Project (Creating an E2 Instance using Terraform)
### Configurations:
1. Install Chocolatey on Windows
   
Ensure that the terminal is open as admin
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
2. Install Terraform on Windows
```
choco install terraform
```

### Deployments:
1. Create and set up the terraform file (main.tf)
```
vim main.tf
```
```
DOMAIN= "http://localhost:3000"
PORT=3000
STATIC_DIR="./client"

PUBLISHABLE_KEY=""
SECRET_KEY=""
```
Publishable and secret keys can be left empty for practice.

2. Initialise and start the project
```
npm install
npm start run
```
3. Edit inbound rule in the security group of EC2 to allow traffic.
   
   EC2 > Security Groups > security group id of EC2 > Edit inbound rule > Add rule.

   **Type** = Custom TCP, **Port** = 3000, **Source** = Custom 0.0.0.0/0
<br>
Last but not least, from any local machine enter the IP address of the EC2 Instance and port number to access the application.

Example: 50.75.100.125:3000

---
Reference:
https://github.com/verma-kunal/AWS-Session
