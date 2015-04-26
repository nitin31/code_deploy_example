## Configuring Amazon CodeDeploy

Steps for setting up code deploy:

* Create a new Code Deploy Application.
![create application](https://cloud.githubusercontent.com/assets/9297464/7338114/5b6332dc-ec0f-11e4-9d47-ec773567948f.png)

* Set up git hooks.
![git hooks](https://cloud.githubusercontent.com/assets/9297464/7338116/670624fa-ec0f-11e4-94a4-e88eeb6709ea.png)

* Deploy code.
![codedeploy](https://cloud.githubusercontent.com/assets/9297464/7338118/71dec454-ec0f-11e4-864c-83e965d20b5e.png)

  
For details watch [this](https://www.youtube.com/watch?v=qZa5JXmsWZs) tutorial.
  
For this application, we set up two CodeDeploy Groups. One for deploying on the master and the other for slave (although same content is deployed in both)

## A closer look at what is deployed

The scripts folder has four files:  

* `installapache.sh` - This file automatically installs apache when the instance is created and this code is deployed.
* `restartapache.sh` - Restarts apache server
* `startapache.sh` - Starts apache server
* `statuscheck.sh` - This script is used only on the master instance. It is responsible for checking availability of slave instances, sending alert emails, making changes to modproxy settings when an instance goes down or restarts again.  
  
Next is `appspec.yml` - This file is used to configure aws instance before and after installation of apache.  

The `aws.py` file is not used on any instances, but it is responsible for demonstrating Chaos Monkey.
* It uses the `boto.ec2` api to interact with EC2
* It maintains a list of all slave instances.
* It randomly selects an instance from the list and shuts it down.


`index.html` is a simple web page that is served to demonstrate a simple application. In real life scenarios, any application can take its place. 
