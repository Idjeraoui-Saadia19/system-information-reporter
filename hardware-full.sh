#!/bin/bash

# ===== COLORS =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

clear


echo -e "${CYAN}=========================================="
echo -e "        FULL HARDWARE AUDIT REPORT"
echo "Generated on: $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "==========================================${NC}"

echo -e "${YELLOW}Date:${NC} $(date)"
echo -e "${YELLOW}Hostname:${NC} $(hostname)"
echo -e "${YELLOW}Uptime:${NC} $(uptime -p)"
echo ""

# ===== CPU =====
echo -e "${RED}===== CPU INFORMATION =====${NC}"
lscpu | sed 's/^/  /'
echo ""

# ===== MEMORY =====
echo -e "${GREEN}===== MEMORY INFORMATION =====${NC}"
free -h
echo ""
echo -e "${GREEN}----- Detailed RAM Info -----${NC}"
cat /proc/meminfo | head -20 | sed 's/^/  /'
echo ""

# ===== DISK =====
echo -e "${BLUE}===== DISK INFORMATION =====${NC}"
lsblk
echo ""

echo -e "${BLUE}----- Filesystem Usage -----${NC}"
df -hT
echo ""

# ===== SYSTEM =====
echo -e "${PURPLE}===== SYSTEM INFORMATION =====${NC}"
sudo dmidecode -t system | sed 's/^/  /'
echo ""

echo -e "${PURPLE}===== MOTHERBOARD INFORMATION =====${NC}"
sudo dmidecode -t baseboard | sed 's/^/  /'
echo ""

echo -e "${PURPLE}===== BIOS INFORMATION =====${NC}"
sudo dmidecode -t bios | sed 's/^/  /'
echo ""

# ===== GPU =====
echo -e "${CYAN}===== GPU INFORMATION =====${NC}"
lspci | grep -i vga
echo ""

# ===== NETWORK =====
echo -e "${YELLOW}===== NETWORK INTERFACES =====${NC}"
ip a | sed 's/^/  /'
echo ""

echo -e "${YELLOW}----- Routing Table -----${NC}"
ip route | sed 's/^/  /'
echo ""

echo -e "${YELLOW}----- MAC Addresses -----${NC}"
ip link | grep link | sed 's/^/  /'
echo ""

# ===== USB =====
echo -e "${GREEN}===== USB DEVICES =====${NC}"
lsusb
echo ""

# ===== PCI =====
echo -e "${RED}===== PCI DEVICES =====${NC}"
lspci
echo ""

# ===== SENSORS =====
echo -e "${BLUE}===== HARDWARE SENSORS =====${NC}"
sensors 2>/dev/null || echo "  sensors not installed (sudo apt install lm-sensors)"
echo ""

echo -e "${CYAN}=========================================="
echo -e "              REPORT END"
echo -e "==========================================${NC}"