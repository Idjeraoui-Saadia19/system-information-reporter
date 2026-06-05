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
# DIRECTORIES
############################
BASE="$HOME/system-reporter"
OUT="$BASE/outputs"
LOG="$BASE/logs"

MAX_REPORTS=10

mkdir -p "$OUT" "$LOG"

LOG_FILE="$LOG/history.log"
LAST_REPORT_FILE="$LOG/last_report.txt"

log_action() {
    echo "[$(date)] $1" >> "$LOG_FILE"
}

############################
# CLEAN OLD REPORTS
############################
cleanup_reports() {
    ls -t "$OUT"/report_*.txt 2>/dev/null | tail -n +$((MAX_REPORTS+1)) | xargs -r rm --
}

clear

while true; do

echo -e "${CYAN}${BOLD}"
echo "=========================================="
echo "        SYSTEM REPORT GENERATOR          "
echo "=========================================="
echo -e "${NC}"

echo "1) Hardware"
echo "2) Software"
echo "3) View Last Report"
echo "0) Exit"

read -p "Choose type: " TYPE

############################
# EXIT OR LAST REPORT
############################
if [ "$TYPE" = "0" ]; then
    echo "Bye!"
    break
fi

if [ "$TYPE" = "3" ]; then
    if [ -f "$LAST_REPORT_FILE" ]; then
        FILE_TO_OPEN=$(cat "$LAST_REPORT_FILE")
        echo "Opening: $FILE_TO_OPEN"
        less "$FILE_TO_OPEN"
    else
        echo -e "${RED}No report found${NC}"
    fi
    continue
fi

echo ""

echo "1) Full Report"
echo "2) Short Report"
read -p "Choose level: " LEVEL

echo ""

echo "1) Terminal"
echo "2) Save to File"
echo "3) Send Email"
read -p "Choose output: " OUTPUT

EMAIL=""

if [ "$OUTPUT" = "3" ]; then
    read -p "Enter recipient email: " EMAIL
    read -p "SMTP username: " USER
    echo ""
fi

############################
# GENERATE REPORT CONTENT
############################
get_report() {
    bash "$1"
}

if [ "$TYPE" = "1" ] && [ "$LEVEL" = "1" ]; then
    CONTENT=$(get_report "./hardware-full.sh")
elif [ "$TYPE" = "1" ] && [ "$LEVEL" = "2" ]; then
    CONTENT=$(get_report "./hardware-short.sh")
elif [ "$TYPE" = "2" ] && [ "$LEVEL" = "1" ]; then
    CONTENT=$(get_report "./software-full.sh")
elif [ "$TYPE" = "2" ] && [ "$LEVEL" = "2" ]; then
    CONTENT=$(get_report "./software-short.sh")
else
    echo -e "${RED}Invalid selection${NC}"
    continue
fi

############################
# HEALTH SCORE
############################
RAM=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')
DISK=$(df / | awk 'END{print $5}' | tr -d '%')

SCORE=100

if (( RAM > 80 )); then SCORE=$((SCORE-25)); fi
if (( DISK > 85 )); then SCORE=$((SCORE-25)); fi

if (( SCORE >= 80 )); then
    STATUS="GOOD"
elif (( SCORE >= 50 )); then
    STATUS="WARNING"
else
    STATUS="CRITICAL"
fi

HEALTH="Health Score: $SCORE/100 | Status: $STATUS"

############################
# FINAL REPORT
############################
REPORT="
==========================================
 SYSTEM REPORT - $(date)
==========================================

$CONTENT

==========================================
$HEALTH
==========================================
"

############################
# CREATE FILE + TRACK IT
############################
FILE="$OUT/report_$(date +%Y-%m-%d_%H-%M-%S).txt"
echo "$REPORT" > "$FILE"
echo "$FILE" > "$LAST_REPORT_FILE"

cleanup_reports

############################
# OUTPUT HANDLING
############################

if [ "$OUTPUT" = "1" ]; then
    echo -e "$REPORT"

elif [ "$OUTPUT" = "2" ]; then
    echo -e "${GREEN}Saved automatically: $FILE${NC}"
    log_action "Saved report: $FILE"

    read -p "Open report now? (y/n): " OPEN
    if [ "$OPEN" = "y" ]; then
        less "$FILE"
    fi

elif [ "$OUTPUT" = "3" ]; then
    TMP="/tmp/report.txt"
    echo -e "$REPORT" > "$TMP"