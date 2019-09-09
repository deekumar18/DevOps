groupadd -g 2002 njsadmin
useradd -u 2002 -g 2002 njsadmin -c "NodeJS Application User" -s /bin/bash
mkdir -p /var/log/cmg-esb-stub
chown njsadmin:njsadmin /var/log/cmg-esb-stub
