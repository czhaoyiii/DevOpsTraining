## 1st Project (Deploying a Node Js Application on AWS EC2)

### Configurations:
1. Update outdated packages & dependencies
```
sudo apt update
```
2. Required to install git on VM
```
sudo apt install git
```
3. Required to install Node.js on VM
```
sudo apt install nodejs
```
4. Required to install npm on VM
```
sudo apt install npm
```
### Deployments:
1. Create and set up the environment variables (.env)
```
vim .env
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
