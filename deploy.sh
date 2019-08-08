#!/usr/bin/env bash

ssh ubuntu@"${SERVER_ADDR?}" "cd /home/ubuntu;rm -rf ./ztl_project;mkdir ztl_project"
scp -r ./dist/* ubuntu@"${SERVER_ADDR?}":/home/ubuntu/ztl_project
ssh ubuntu@"${SERVER_ADDR?}" "sudo rm -rf /var/www/html/*;sudo mv /home/ubuntu/ztl_project/* /var/www/html"
