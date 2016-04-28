#!/bin/sh

[ ! -d /var/lib/mongo ] && sudo mkdir /var/lib/mongo
sudo mount /dev/mapper/MongoVG-MongoLV /var/lib/mongo
