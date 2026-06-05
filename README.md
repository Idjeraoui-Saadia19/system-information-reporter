# System Information & Automation Reporter (School Project)

##  Overview

This project (School project) is a collection of operating system scripts that collect hardware and software information, generate customizable reports, store report history, and support automated reporting via cron jobs and email delivery. Reports can be viewed in the terminal, saved to files, or sent via email based on user preference.

---

##  Features

###  Manual Mode (main.sh)

* Interactive menu system
* Hardware report generation (full / short)
* Software report generation (full / short)
* View last generated report
* Save reports automatically to files
* Send reports via email (msmtp)
* System health score (RAM + Disk usage)

---

##  Reports

### Hardware Reports

* Hardware Full Report
* Hardware Short Report

### Software Reports

* Software Full Report
* Software Short Report

Each report includes:

* CPU usage
* RAM usage
* Disk usage
* Operating system information
* Running processes
* Network status

---

##  Automation (Cron Jobs)

The system supports automated report generation using cron jobs:

* Daily short reports
* Weekly full system audits

Reports are automatically saved in the `outputs/` directory with timestamps.

---

##  Project Structure

```
system-reporter/
│
├── main.sh
├── hardware-full.sh
├── hardware-short.sh
├── software-full.sh
├── software-short.sh
│
├── README.md
├── outputs/
└── logs/
```

---

##  How to Run

### 1. Give execution permission

```bash
chmod +x *.sh
```

### 2. Run the main script

```bash
./main.sh
```

---

##  Email Feature

Reports can be sent automatically via email using `msmtp`.

---

##  Optional Features

* Email delivery system
* System health scoring
* Log history tracking
* Report rotation (keeps last 10 reports)
* Cron-based automation

---

##  Purpose

This project was developed as a school assignment to demonstrate skills in:

* Linux system administration
* Shell scripting
* Automation using cron
* System monitoring and reporting


