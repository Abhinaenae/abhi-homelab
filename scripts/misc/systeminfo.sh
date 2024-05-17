#!/bin/bash

# Author: Abhinay Lavu
# Date: 05/16/2024
# Description: This script will show network connectivity with router and google,
# What the system is currently running
# Who is currently logged on to the system
# Status of CPU Temperatures
# Usage of CPU, Memory, and Disk


# Define the custom labels and their corresponding IPs
HOSTS=(
  "Router:192.168.1.1"
  "Google:google.com"
)

# Define temperature thresholds (in Celsius)
HIGH_TEMP_THRESHOLD=85.0
CRITICAL_TEMP_THRESHOLD=105.0

echo "System is running `uname`"

cat /etc/*release | grep VERSION=

echo

echo "`who | awk '{print $1}'` are currently logged in"

echo

echo
# Function to check host connectivity
check_connectivity() {
  local label=$1
  local ip=$2
  if ping -c 1 $ip &> /dev/null; then
    echo "$label ($ip) is reachable."
  else
    echo "$label ($ip) is not reachable."
  fi
}

# Function to get temperature status
get_temp_status() {
  local temp=$1
  if (( $(echo "$temp >= $CRITICAL_TEMP_THRESHOLD" | bc -l) )); then
    echo "CRITICAL"
  elif (( $(echo "$temp >= $HIGH_TEMP_THRESHOLD" | bc -l) )); then
    echo "HIGH"
  else
    echo "NORMAL"
  fi
}

# Function to get CPU temperature and check for high/critical levels
get_cpu_temperature() {
  local output=""
  local package_temp=$(sensors | grep 'Package id 0:' | awk '{print $4}' | sed 's/+//; s/°C//')
  local package_status=$(get_temp_status $package_temp)

  output+="Package id 0: $package_temp°C ($package_status)\n"

  # Get temperatures of individual cores
  local core_temps=$(sensors | grep 'Core')
  while IFS= read -r line; do
    local core_temp=$(echo $line | awk '{print $3}' | sed 's/+//; s/°C//')
    local core_status=$(get_temp_status $core_temp)
    local core_name=$(echo $line | awk '{print $1,$2}')
    output+="$core_name $core_temp°C ($core_status)\n"
  done <<< "$core_temps"

  echo -e "$output"
}

# Function to get CPU load
get_cpu_load() {
  local load=$(awk -F'load average: ' '{print $2}' <(uptime) | cut -d, -f1)
  local cpu_cores=$(nproc)
  local cpu_usage=$(echo "$load / $cpu_cores * 100" | bc -l)
  echo "CPU USAGE: $(printf "%.0f" $cpu_usage)%"
}

# Function to get memory usage
get_memory_usage() {
  local total_mem=$(free -m | awk '/^Mem:/{print $2}')
  local used_mem=$(free -m | awk '/^Mem:/{print $3}')
  local mem_usage=$(echo "scale=2; $used_mem / $total_mem * 100" | bc -l)
  echo "Memory USAGE: $(printf "%.2f" $mem_usage)%"
}
# Collect information
HOSTS_STATUS=""
for HOST in "${HOSTS[@]}"; do
  LABEL=$(echo $HOST | cut -d: -f1)
  IP=$(echo $HOST | cut -d: -f2)
  HOSTS_STATUS+=$(check_connectivity $LABEL $IP)
  HOSTS_STATUS+="\n"
done

CPU_TEMPERATURE=$(get_cpu_temperature)
CPU_LOAD=$(get_cpu_load)
MEMORY_USAGE=$(get_memory_usage)

# Prepare the output content
OUTPUT="Hosts Connectivity Status:
$HOSTS_STATUS


CPU Temperature:
$CPU_TEMPERATURE


$CPU_LOAD
$MEMORY_USAGE"


# Print the output to the console
echo -e "$OUTPUT"

echo
echo
df -h
