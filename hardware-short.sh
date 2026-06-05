#!/bin/bash

OUTPUT="hardware_short_report.txt"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Clear previous file
> "$OUTPUT"

echo -e "${CYAN}==========================================" | tee -a "$OUTPUT"
echo -e "${CYAN}        SHORT HARDWARE SUMMARY            ${NC}" | tee -a "$OUTPUT"
echo "Generated on: $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "${CYAN}==========================================${NC}" | tee -a "$OUTPUT"

echo -e "Date: $(date)" | tee -a "$OUTPUT"
echo -e "Hostname: $(hostname)" | tee -a "$OUTPUT"
echo -e "Uptime: $(uptime -p)" | tee -a "$OUTPUT"
echo "" | tee -a "$OUTPUT"

# ================= CPU =================
echo -e "${YELLOW}===== CPU INFORMATION =====${NC}" | tee -a "$OUTPUT"

CPU_MODEL=$(lscpu | grep "Model name" | cut -d ':' -f2 | sed 's/^ *//')
CPU_CORES=$(nproc)

echo "CPU: $CPU_MODEL" | tee -a "$OUTPUT"
echo "Cores: $CPU_CORES" | tee -a "$OUTPUT"
echo "" | tee -a "$OUTPUT"

# ================= RAM =================
echo -e "${GREEN}===== MEMORY (RAM) =====${NC}" | tee -a "$OUTPUT"

TOTAL_RAM=$(free -h | awk '/Mem:/ {print $2}')
USED_RAM=$(free -h | awk '/Mem:/ {print $3}')

echo "RAM Total: $TOTAL_RAM" | tee -a "$OUTPUT"
echo "RAM Used: $USED_RAM" | tee -a "$OUTPUT"
echo "" | tee -a "$OUTPUT"

# ================= DISK =================
echo -e "${BLUE}===== DISK USAGE =====${NC}" | tee -a "$OUTPUT"

DISK_TOTAL=$(df -h / | awk 'END{print $2}')
DISK_USED=$(df -h / | awk 'END{print $3}')
DISK_PERCENT=$(df -h / | awk 'END{print $5}')

echo "Disk Total: $DISK_TOTAL" | tee -a "$OUTPUT"
echo "Disk Used: $DISK_USED ($DISK_PERCENT)" | tee -a "$OUTPUT"
echo "" | tee -a "$OUTPUT"

# ================= GPU =================
echo -e "${YELLOW}===== GPU INFORMATION =====${NC}" | tee -a "$OUTPUT"

GPU=$(lspci | grep -i vga | cut -d ":" -f3 | sed 's/^ *//')

echo "GPU: $GPU" | tee -a "$OUTPUT"
echo "" | tee -a "$OUTPUT"

# ================= NETWORK =================
echo -e "${GREEN}===== NETWORK INFO =====${NC}" | tee -a "$OUTPUT"

IP=$(hostname -I | awk '{print $1}')
MAC=$(ip link | awk '/ether/ {print $2; exit}')

echo "IP Address: $IP" | tee -a "$OUTPUT"
echo "MAC Address: $MAC" | tee -a "$OUTPUT"
echo "" | tee -a "$OUTPUT"

# ================= SYSTEM =================
echo -e "${BLUE}===== SYSTEM INFO =====${NC}" | tee -a "$OUTPUT"

ARCH=$(uname -m)
KERNEL=$(uname -r)

echo "Architecture: $ARCH" | tee -a "$OUTPUT"
echo "Kernel: $KERNEL" | tee -a "$OUTPUT"

echo ""
echo -e "${CYAN}Short hardware report saved in $OUTPUT${NC}"