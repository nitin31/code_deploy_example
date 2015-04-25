#!/usr/bin/env bash
timePeriod=60  # time to check status  ... measured in seconds

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
      response=`curl -Is $slave | head -1`
        if [ -z "$response" ] ; then
            echo "Alert ! $slave is down ! ";
            echo "   " ;
            echo "$slave .... $emailContentStr" | mail -s "$slave $emailSubjectStr"  $emailAddr ;
        else
           echo "Our web application is running is just fine on $slave . See response below: ";
           curl -Is $slave | head -1;
           echo "   " ;
        fi
    done
    sleep $timePeriod
done
