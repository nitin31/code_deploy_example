
## DevOps Course Project - Special Milestone
####Team - Akond Rahman, Nitin Sharma, Sakthi Sambasivam

###Demonstration of Chaos Monkey

To demonstrate Chaos Monkey, we have a Master-Slave architecture. The master node is assumed to be always up (in real life scenairos, we can introduce redundancy in masters to achieve this goal). 

Role of the master instance: 
* Maintain a list of available slave instances and distribute incoming traffic evenly among them using mod_proxy. 
* Ping slave instances regularly to make sure no instance is down.
* If a slave instance goes down, Master should send an alert mail to the administrator and automatically redistribute the traffic among "now" available instances (explained later).
* For details on what goes on in master see [MASTER.md](MASTER.md)

After we have a master-slave architecture in place, we set up Amazon CodeDeploy to manage deployments automatically. For details see [CODEDEPLOY.md](CODEDEPLOY.md)

To demonstrate a Chaos Monkey, we use a python script included in the repo (aws.py) to randomly select and stop a slave instance. When this happens, the system does the following:
* Master instance realizes the instance is down and updates it mod proxy settings to reflect the change. Now the proxy redirects traffic to only the available instances.
* An email is sent to the administrator with the server address of the instance that shut down.
* The master also keeps pinging the instances that are down. As soon as an instance comes back up again, mod proxy settings are changed and it is added to the list of instances where incomming traffic is being redirected.




