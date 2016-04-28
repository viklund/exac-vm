#!/bin/sh

set -e
set -x

if [ -f /etc/disk_added_date ] ; then
   echo "disk already added so exiting."
   exit 0
fi

sudo fdisk -u /dev/sdb <<EOF
n
p
1


t
8e
w
EOF

sudo pvcreate /dev/sdb1
sudo vgcreate MongoVG /dev/sdb1
sudo lvcreate -n MongoLV -l 100%VG MongoVG
sudo mkfs.ext4 /dev/mapper/MongoVG-MongoLV

sudo sh -c 'date > /etc/disk_added_date'
