# System Reporter Project

## Overview
This project is a Linux-based system monitoring and reporting tool developed using Bash scripting.  
It generates hardware and software reports in different formats (full and short), and supports automation, logging, and optional email sending.

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