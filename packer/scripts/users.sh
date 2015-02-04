groupadd docker
groupadd zenoss --gid 1206
groupadd awsadmins --gid 1001

useradd zenoss -b /home/zenoss --uid 1337 --gid 1206 --groups sudo,docker,awsadmins --shell /bin/bash
echo "zenoss:zenoss" | chpasswd
mkdir -p /home/zenoss/.ssh
chowner zenoss:zenoss /home/zenoss/.ssh
chmod 700 /home/zenoss/.ssh
