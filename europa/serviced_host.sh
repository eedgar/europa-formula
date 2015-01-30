while [ $(serviced host list | awk '{if (NR == 1) print $1}') != "ID" ]; do sleep 1; done
serviced host add {{ ip[0] }}:4979 default
