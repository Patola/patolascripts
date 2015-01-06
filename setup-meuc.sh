#!/bin/bash

/bin/mkdir -p ~/.ssh
/bin/chmod 700 ~/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAv6VV/9z0EdZmzXTiRyMc+45mnIySnCUikmOigKLHdsq7NxD5cL+ZwbeMK9P6NvaT27R0ONFz0hzMt2Mv7kbTODL0C1TYc+/XxMfUsz1Un9hu7TX0tsOBFeBXmRIMOJMJ1zXKVUso7zJ9ND3Ewrhd9/mC+bL2474A2bryWUpUMXvbcqKXjE7xp0Bqpjgzj53R8SxsWlJTItKmDRCW6t9uBzeQmJ2adCQnVItbxv+u+5HsAdF1C6GZa7Vvquw5YCO/sNaA1eNBGrp8SA3OAMiH9JphXZOHMJg9qwAMS29h9wFV/PMBrJF4i6EqKBztAFk+z1+9uQh3wtAS5W1WChFQCw== root@comain.meuc.softlayer.com' >> ~/.ssh/authorized_keys
#/bin/rpm -ivh http://comain.meuc.softlayer.com/stress-1.0.4-4.el6.x86_64.rpm
/bin/rpm -ivh http://10.56.251.194/stress-1.0.4-4.el6.x86_64.rpm
echo "$(date '+%Y-%m-%d.%H-%M-%S') worked" >> /root/provision-script.log
#/usr/bin/yum -y install stress
