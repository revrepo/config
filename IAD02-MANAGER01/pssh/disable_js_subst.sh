#!/bin/bash

# Keep soft links
sed_in_place() {
	TMP=`mktemp`
	sed "s/RevJSSubst/#RevJSSubst/g" $1 >$TMP
	cat $TMP >$1
	rm $TMP
}

# Disable mod_rev_js_substitute in existing Apache configs
for f in `find /etc/apache2/sites-enabled -name '*.conf'` ; do
	sed_in_place $f
done

# Don't allow configurator to insert RevJSSubstitute... statements into Apache config files
sed -i "s/RevJS/#RevJS/g" /etc/revsw-apache/generic-site/bp.json

for f in `find /etc/revsw-apache -name bp.jinja` ; do
	sed_in_place $f
done

# Fix ban syntax in pc-apache-config.py (will be replaced by permanent fix in the upcoming package)
perl -i -pe 's/\Q"obj.http.X-Rev-Host == %s && obj.http.X-Rev-Url ~ %s"/'\''obj.http.X-Rev-Host == "%s" && obj.http.X-Rev-Url ~ "%s"'\''/' /usr/sbin/pc-apache-config.py

# Disable module and apply changes
a2dismod rev_js_substitute
service revsw-apache2 restart
