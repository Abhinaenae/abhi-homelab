#!/bin/bash
# Author: Abhinay Lavu
# Date: 05/15/2024
# Description: This script will create a file with full permissions

echo "Enter filename to create"
read fname

touch $fname
chmod 777 $fname
echo "$fname has been created"
