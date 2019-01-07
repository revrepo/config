#!/bin/bash

parallel-scp -h all-bp -O StrictHostKeyChecking=no revsw.vcl /tmp/

if [ $? -ne 0 ]; then
	echo "ERROR: Failed to copy the new file"
	exit 1
fi

parallel-ssh -P -h all-bp -O StrictHostKeyChecking=no "sudo cp /etc/varnish/revsw.vcl /etc/varnish/revsw.vcl.bak"
if [ $? -ne 0 ]; then
	echo "ERROR: Failed to make a backup copy of the destination file"
	exit 1
fi

parallel-ssh -P -h all-bp -O StrictHostKeyChecking=no "sudo mv /tmp/revsw.vcl /etc/varnish/revsw.vcl"
if [ $? -ne 0 ]; then
	echo "ERROR: Failed to place the new file to the final destination"
	exit 1
fi


exit 0

parallel-ssh -P -h all-bp -O StrictHostKeyChecking=no "sudo /etc/init.d/varnish reload"
if [ $? -ne 0 ]; then
	echo "ERROR: Failed to reload varnishd
	exit 1
fi



