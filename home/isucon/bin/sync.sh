#!/bin/sh

rsync -a --delete /home/isucon/webapp/ 192.168.0.12:/home/isucon/webapp/
rsync -a --delete /home/isucon/webapp/ 192.168.0.13:/home/isucon/webapp/
