#!/usr/bin/env bash
timePeriod=2  # time to check status  ... measured in seconds

declare -a slaveAddress=('52.10.193.215' '54.149.199.57' '54.213.114.135');


emailContentStr=" ... this AWS instance was shutdown unexpectedly ! ";
emailSubjectStr=" ... AWS Instance : Shutdown ";
emailAddr="nitinsharma0389@gmail.com";


while true
do
    for slave in "${slaveAddress[@]}"
    do
      echo "Testing slave ID: $slave" ;
      echo "   " ;
      response=`curl --connect-timeout 3 -Is $slave | head -1`
        if [ -z "$response" ] ; then
            echo "Alert ! $slave is down ! ";
            echo "Stopping traffic to this server";
            case "$slave" in
            "52.10.193.215")
                    sudo sed -i 's/#*BalancerMember http:\/\/52.10.193.215:80/#BalancerMember http:\/\/52.10.193.215:80/g' /etc/httpd/conf/httpd.conf
                    ;;
            "54.149.199.57")
                    sudo sed -i 's/#*BalancerMember http:\/\/54.149.199.57:80/#BalancerMember http:\/\/54.149.199.57:80/g' /etc/httpd/conf/httpd.conf
                    ;;
            "54.213.114.135")
                   sudo sed -i 's/#*BalancerMember http:\/\/54.213.114.135:80/#BalancerMember http:\/\/54.213.114.135:80/g' /etc/httpd/conf/httpd.conf
                    ;;
            esac
            echo "   " ;
            echo "$slave .... $emailContentStr" | mail -r admin-EC2@aws -s "$slave $emailSubjectStr"  $emailAddr ;
        else
           echo "Our web application is running is just fine on $slave . See response below: ";
	   case "$slave" in
            "52.10.193.215")
                    sudo sed -i 's/#*BalancerMember http:\/\/52.10.193.215:80/BalancerMember http:\/\/52.10.193.215:80/g' /etc/httpd/conf/httpd.conf
                    ;;
            "54.149.199.57")
                    sudo sed -i 's/#*BalancerMember http:\/\/54.149.199.57:80/BalancerMember http:\/\/54.149.199.57:80/g' /etc/httpd/conf/httpd.conf
                    ;;
            "54.213.114.135")
                    sudo sed -i 's/#*BalancerMember http:\/\/54.213.114.135:80/BalancerMember http:\/\/54.213.114.135:80/g' /etc/httpd/conf/httpd.conf
                    ;;
           esac

           curl -Is $slave | head -1;
           echo "   " ;
        fi
    done
    sleep $timePeriod
done

