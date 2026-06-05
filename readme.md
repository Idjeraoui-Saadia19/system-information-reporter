# system-information-reporter

## Overview
This project ( School project): A collection of operating system scripts that collect hardware and software information, generate customizable reports, store report history, and support automated reporting via cron jobs and email delivery. Reports can be viewed in the terminal, saved to files, or sent via email based on user preference.
---

## Features

### 🔹 Manual Mode (main.sh)
- Interactive menu system
- Hardware report generation (full / short)
- Software report generation (full / short)
- View last generated report
- Save reports to files
- Send reports via email (msmtp)
- System health score (RAM + Disk usage)

---

### Reports
- Hardware Full Report
- Hardware Short Report
- Software Full Report
- Software Short Report

Each report contains system information such as:
- CPU, RAM, Disk usage
- OS information
- Running processes
- Network and system status

---

### Automation (Cron Jobs)
The system supports automatic report generation using cron jobs:

- Daily short reports
- Weekly full system audits

Reports are saved automatically in the outputs directory with timestamps.

---

## Project Structure
system-reporter/
│
├── main.sh
├── hardware-full.sh
├── hardware-short.sh
├── software-full.sh
├── software-short.sh
│
│
├── README.md
│
├── outputs/
└── logs/

---

## How to Run

### 1. Give permission

 bash : chmod +x *.sh

### 2. Run main script 

 bash : ./main.sh

---

## Optional Features

### Sending via Email

### Health scoring system

### Log history

---

### Report rotation (keeping last 10 reports)

---
Developed as a student project for Linux system monitoring and automation.
