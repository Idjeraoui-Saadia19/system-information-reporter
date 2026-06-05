#!/bin/bash

############################
# COLORS
############################
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

############################
# HEADER
############################
echo -e "${CYAN}${BOLD}"
echo "=========================================="
echo "        SOFTWARE SHORT REPORT            "
echo "Generated on: $(date '+%Y-%m-%d %H:%M:%S')"
echo "=========================================="
echo -e "${NC}"

############################
# BASIC SYSTEM INFO
############################
echo -e "${YELLOW}===== SYSTEM INFORMATION =====${NC}"

OS=$(lsb_release -d 2>/dev/null | cut -f2)

echo -e "${GREEN}Operating System:${NC} $OS"
echo -e "${GREEN}Kernel Version:${NC} $(uname -r)"
echo -e "${GREEN}Architecture:${NC} $(uname -m)"
echo -e "${GREEN}Hostname:${NC} $(hostname)"
echo -e "${GREEN}Uptime:${NC} $(uptime -p)"

echo ""

############################
# SHELL INFO
############################
echo -e "${BLUE}===== SHELL INFORMATION =====${NC}"

echo -e "${GREEN}Default Shell:${NC} $SHELL"
echo -e "${GREEN}User:${NC} $USER"

echo ""

############################
# PACKAGES SUMMARY
############################
echo -e "${PURPLE}===== PACKAGE INFORMATION =====${NC}"

if command -v dpkg >/dev/null 2>&1; then
    PKG_COUNT=$(dpkg --get-selections | wc -l)
    echo -e "${GREEN}Installed Packages:${NC} $PKG_COUNT"
else
    echo -e "${RED}dpkg not available${NC}"
fi

echo ""

############################
# PROCESS SUMMARY
############################
echo -e "${YELLOW}===== PROCESS INFO =====${NC}"

echo -e "${GREEN}Running Processes:${NC} $(ps aux | wc -l)"

echo ""

############################
# NETWORK INFO
############################
echo -e "${CYAN}===== NETWORK INFO =====${NC}"

IP=$(hostname -I | awk '{print $1}')

echo -e "${GREEN}IP Address:${NC} $IP"

echo ""

############################
# FOOTER
############################
echo -e "${CYAN}${BOLD}Software short report completed.${NC}"