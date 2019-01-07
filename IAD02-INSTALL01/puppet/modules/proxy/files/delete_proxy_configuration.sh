#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

if [ "$1" = "delete_all_configs" ]; then
	rm -rf /opt/revsw-config/policy/*
	find /opt/revsw-config/apache -mindepth 1 -maxdepth 1 -not -name 'generic-site' -exec rm -rf {} \;
	rm -rf /opt/revsw-config/varnish/sites/*.json
	rm -rf /etc/nginx/sites-enabled/*
	rm -rf /etc/nginx/sites-available/*
	exit 0
fi

if [ "$1" = "purge_delete_command_files" ]; then
	 find /opt/revsw-config/policy/*|while read f; do echo Checking file  $f; if `grep '"operation":"delete"' "$f" > /dev/null` ; then echo Removing file $f; rm $f; fi; done 
	exit 0
fi

exit 1
