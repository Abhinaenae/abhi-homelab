#! /bin/bash

#Gets system statistics for:
#CPU Usage
#Free vs Used Memory Usage%
#Free vs Used Disk Usage%
#Top 5 most CPU using processes
#Top 5 most MEM using processes

echo "SYSTEM STATISTICS:\n\n"
#Find CPU Usage
idle=$(mpstat | awk '/all/ {print $NF}')
util=$(echo "100 - $idle" | bc)
echo "CPU Usage: ($util)%"
echo -e "\n\n"
############################################################
memory=$(free -m | awk 'NR==2{print $3, $4, $2}')
#Parsing fields
usedmem=$(echo $memory | awk '{print $1}')
freemem=$(echo $memory | awk '{print $2}')
totalmem=$(echo $memory | awk '{print $3}')

#getting percenatge
used_mem=$(echo "scale=2; (${usedmem}/${totalmem}) * 100" | bc)
free_mem=$(echo "scale=2; (${freemem}/${totalmem}) * 100" | bc)

#$Display Fields
echo "Total Memory: ${totalmem}MB"
echo "Used Memory: ${usedmem}MB (${used_mem}%)"
echo "Free Memory: ${freemem}MB (${free_mem}%)"
echo -e "\n\n"
############################################################
disk_info=$(df -h / | awk 'NR==2{print $3, $4, $2}')
used_disk=$(echo $disk_info | awk '{print $1}')   # Used spac
free_disk=$(echo $disk_info | awk '{print $2}')   # Free space
total_disk=$(df -h / | awk 'NR==2{print $2}')      # Total size
# Calculate percentage of used disk space
used_percent=$(echo "scale=2; ($used_disk/$total_disk)*100" | bc)
# Display field
echo "Total Disk Space: ${total_disk}"
echo "Used Disk Space: ${used_disk} (${used_percent}%)"
echo "Unused Disk Space: ${free_disk})"
echo -e "\n\n"
#############################################################
t5processCPU=$(ps aux | sort -nrk 3,3 | head -n 5)
echo -e "Top 5 highest CPU-utilizing processes:\n${t5processCPU}"
echo -e "\n\n"
#############################################################
t5processMEM=$(ps aux | sort -nrk 4,4 | head -n 5)
echo -e "Top 5 highest MEM-utilizing processes:\n${t5processMEM}"
echo -e "\n\n"
