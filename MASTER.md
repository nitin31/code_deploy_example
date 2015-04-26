##This file explains the operation of Master Instance

###Configuring the mod proxy

* Mod Proxy is available with apache server. 
* To enable mod proxy, we can make changes to `httpd.conf` file. Screenshot is attached below.  

![mod proxy](https://cloud.githubusercontent.com/assets/9297464/7338248/1e174134-ec14-11e4-9853-95b28b66a6de.png)

* At this point, mod proxy redirects traffic to all the given `Balancer Members` in a round robin fashion.

###Monitoring slave instances

* The next job of the Master instance is to monitor the slave instances.
* This is done through `statuscheck.py` script. 

![master1](https://cloud.githubusercontent.com/assets/9297464/7338285/330b10f6-ec15-11e4-99a7-b3e535708332.png)

* The script checks after the slaves and modifies the `httpd.conf` file when an instance goes down or comes back up. 
* The script is included in the repo.


