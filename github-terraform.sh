#!/bin/bash

commit=$(date +"%d-%m-%H-%M-%S")

find /home/amanpathak/Downloads/Terraform2/ -name "*.terraform" -exec rm -rf {} \;
cd /home/amanpathak/Downloads/Terraform2/
git checkout main
git add .
git commit -m $commit
git remote add origin "https://github.com/AmanPathak-dev/Terraform.git"
git push -u origin main
