# /usr/bin/python2.7
# written by Tomas Nevar (http://www.lisenet.com) on 05/11/2012
# copyleft free software

import boto.ec2
import sys
import random

# specify AWS keys
auth = {"aws_access_key_id": "###################", "aws_secret_access_key": "###############################"}
instance_list = ["i-1","i-2","i-3"]  # Instance id list

def main():
    # read arguments from the command line and 
    # check whether at least two elements were entered
    if len(sys.argv) < 2:
	print "Usage: python aws.py {stop}\n"
	sys.exit(0)
    else:
	action = sys.argv[1] 

    if action == "stop":
    	stopInstance()
    else:
    	print "Usage: python aws.py {stop}\n"


def stopInstance():
    print "Stopping the instance..."
    random_instance = random.randrange(0,3)
    random_instance_id = instance_list[random_instance]
    
    try:
        ec2 = boto.ec2.connect_to_region("us-west-2", **auth)

    except Exception, e1:
        error1 = "Error1: %s" % str(e1)
        print(error1)
        sys.exit(0)

    try:
        ec2.stop_instances(instance_ids=random_instance_id)
	
    except Exception, e2:
        error2 = "Error2: %s" % str(e2)
        print(error2)
        sys.exit(0)

if __name__ == '__main__':
    main()
