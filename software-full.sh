#!/bin/bash


# ================= COLORS =================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

OUTPUT_FILE="full_report_$(date +%Y%m%d_%H%M%S).txt"

echo "Starting full report generation: $OUTPUT_FILE"
echo -e "${CYAN}=========================================="
echo -e "        FULL SOFTWARE AUDIT REPORT"
echo "Generated on: $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "==========================================${NC}"
echo -e "${BLUE}===== SYSTEM INFORMATION =====${NC}"

echo -e "${CYAN}Hostname:${NC} $(hostname)"

echo -e "${CYAN}OS:${NC} $(lsb_release -d 2>/dev/null | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')"

echo -e "${CYAN}Kernel:${NC} $(uname -r)"

echo -e "${CYAN}Kernel modules loaded:${NC} $(lsmod | wc -l)"

echo -e "${CYAN}Architecture:${NC} $(uname -m)"

echo -e "${CYAN}Uptime:${NC} $(uptime -p)"

echo -e "${CYAN}Last reboot:${NC} $(who -b)"

echo -e "${CYAN}Logged-in users:${NC}"
who | column
echo

echo -e "${CYAN}Users in /etc/passwd:${NC}"
cut -d: -f1 /etc/passwd | column

echo -e "${CYAN}Current date and time:${NC} $(date)"

echo -e "${CYAN}System boot time:${NC} $(uptime -s)"

echo -e "${CYAN}Current runlevel/target:${NC} $(runlevel | awk '{print $2}')"
echo

# ================= SOFTWARE =================
echo -e "${BLUE}===== SOFTWARE PACKAGES =====${NC}"

if command -v dpkg >/dev/null 2>&1; then
    echo -e "${GREEN}Total installed packages (dpkg):${NC} $(dpkg -l | wc -l)"

    echo -e "${YELLOW}Top 20 packages by size:${NC}"
    dpkg-query -Wf='${Installed-Size}\t${Package}\n' | sort -nr | head -20 | column -t

elif command -v rpm >/dev/null 2>&1; then
    echo -e "${GREEN}Total installed packages (rpm):${NC} $(rpm -qa | wc -l)"
    echo -e "${YELLOW}Top 20 packages by size:${NC}"
    rpm -qa --queryformat '%{SIZE}\t%{NAME}\n' | sort -nr | head -20 | column -t
else
    echo -e "${RED}Package manager not detected.${NC}"
fi

echo
echo -e "${CYAN}Environment variables:${NC}"
echo ""
echo "USER: $USER"
echo "HOME: $HOME"
echo "SHELL: $SHELL"
echo "PATH: $PATH"
echo "LANG: $LANG"
echo "PWD: $PWD"
echo

# ================= STORAGE =================
echo -e "${BLUE}===== STORAGE INFORMATION =====${NC}"

echo -e "${CYAN}Disk Usage:${NC}"
df -h

echo -e "${CYAN}Directory Sizes:${NC}"
du -sh /* 2>/dev/null

echo -e "${YELLOW}Critical Partitions (>80%):${NC}"
df -h | awk '$5+0 > 80 {print}'

echo "Collected storage info"

# ================= NETWORK =================
echo -e "${BLUE}===== NETWORK INFORMATION =====${NC}"

echo -e "${CYAN}Local IP Addresses:${NC}"
ip a

echo -e "${CYAN}Routing table:${NC}"
ip route | column -t

echo -e "${CYAN}Default gateway:${NC}"
ip route | grep default

echo -e "${CYAN}DNS servers:${NC}"
grep nameserver /etc/resolv.conf

echo -e "${CYAN}Active connections:${NC}"
ss -tunap

echo -e "${CYAN}Listening ports:${NC}"
ss -tulnp 2>/dev/null | column -t

echo -e "${YELLOW}netstat not installed${NC}"
echo

# ================= SECURITY =================
echo -e "${BLUE}===== SECURITY INFORMATION =====${NC}"

echo -e "${CYAN}Logged-in Users:${NC}"
who

echo -e "${CYAN}User Accounts:${NC}"
cut -d: -f1 /etc/passwd

echo -e "${YELLOW}Failed Login Attempts:${NC}"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -n 10

echo -e "${YELLOW}Sudo Activity:${NC}"
grep "sudo" /var/log/auth.log 2>/dev/null | tail -n 10

echo -e "${CYAN}Sensitive File Permissions (/etc/shadow):${NC}"
ls -l /etc/shadow 2>/dev/null

echo -e "${CYAN}Firewall Status:${NC}"
sudo ufw status 2>/dev/null

echo "Collected security info"

# ================= ALERTS =================
echo -e "${BLUE}===== ALERTS =====${NC}"

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)

if [ "$DISK_USAGE" -gt 80 ]; then
    echo -e "${RED}WARNING: Disk usage above 80%${NC}"
fi

if [ "$CPU_LOAD" -gt 80 ]; then
    echo -e "${RED}WARNING: High CPU usage${NC}"
fi

systemctl --failed | grep "failed" >/dev/null && \
echo -e "${RED}WARNING: Failed services detected${NC}"
echo "Checked alerts"