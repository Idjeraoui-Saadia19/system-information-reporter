# 🇩🇿 Linux System Audit & Monitoring using Shell Scripting

### Design and Implementation of an Automated Hardware & Software Audit System

---

## 📌 Overview

This project is a Linux-based system audit and monitoring tool developed using Bash scripting. It automates the collection of hardware and software information, generates structured reports, stores report history, and supports automated reporting via cron jobs and email delivery.

The goal is to replace manual system inspection commands with a single automated and interactive solution.

---

## 🎯 Project Information

**People’s Democratic Republic of Algeria**
**Ministry of Higher Education and Scientific Research**
**National Higher School of Cybersecurity**

### Project Title:

Design and Implementation of an Automated Hardware & Software Audit System with Reporting and Remote Monitoring Capabilities

### Group Members:

* SIF Israa
* IDJERAOUI Saadia

### Supervised by:

Dr. Bentrad Sassi

### Academic Year:

2025/2026

---

## ⚙️ Features

### 🔹 Manual Mode (main.sh)

* Interactive menu system
* Hardware and software report generation (full / short)
* View last generated report
* Save reports to files
* Send reports via email (msmtp)
* System health score (RAM + Disk usage)

---

## 📊 System Reports

### 🖥️ Hardware Reports

* CPU (model, cores)
* RAM usage
* Disk usage
* BIOS & motherboard information
* GPU information
* USB & PCI devices
* Network interfaces

### 💻 Software Reports

* OS and kernel version
* Installed packages
* Running processes
* Logged-in users
* Environment variables
* Active connections & open ports
* Firewall status
* Security logs

---

## ⏱️ Automation (Cron Jobs)

The system supports automated execution using cron jobs:

* Daily short reports
* Weekly full system audits

Reports are automatically stored in:

```
outputs/
```

Logs are stored in:

```
logs/
```

---

## 🧠 System Logic

1. User selects an option from the menu
2. System determines the correct script
3. Linux commands are executed
4. Output is captured
5. Report is formatted
6. Health score is calculated:

   * RAM usage
   * Disk usage
     → Output: GOOD / WARNING / CRITICAL
7. Result is delivered via:

   * Terminal
   * File
   * Email

---

## 🛠️ Technologies Used

* Linux (Ubuntu)
* Bash Shell Scripting
* Cron Jobs (automation)
* msmtp (email sending)
* Linux system commands:

  * `lscpu`, `free -h`, `df -h`, `ip a`, `ss`, `dpkg`
* Text processing tools:

  * `grep`, `awk`, `sed`, `cut`, `column`

---

## 📁 Project Structure

```
system-reporter/
│
├── main.sh
├── hardware-full.sh
├── hardware-short.sh
├── software-full.sh
├── software-short.sh
│
├── outputs/
├── logs/
└── README.md
```

---

## 🚀 How to Run

### 1. Give permissions

```bash
chmod +x *.sh
```

### 2. Run the program

```bash
./main.sh
```

---

## 📌 Use Cases

* System administration
* Technical maintenance
* Education (Linux learning tool)
* Small organizations
* Cybersecurity monitoring

---

## 🔐 Cybersecurity Importance

This tool helps detect:

* Failed login attempts
* Open ports
* Suspicious network activity
* Unauthorized users
* Firewall misconfigurations

It acts as a beginner-level security auditing system.

---

## ⚠️ Limitations

* No graphical interface (CLI only)
* Limited remote SSH automation
* Works best on local systems
* Some advanced features not implemented due to time constraints

---

## 🔮 Future Improvements

* Graphical interface (GUI)
* Remote system monitoring
* PDF report export
* Real-time alerts
* Advanced intrusion detection
* Improved email formatting
* SSH automation support

---

## 🧾 Conclusion

This project provided strong hands-on experience in Linux system administration, Bash scripting, and automation. It demonstrates how manual system inspection tasks can be transformed into an efficient automated auditing tool.

From a cybersecurity perspective, it introduces basic system monitoring and defensive analysis techniques.

Overall, this project bridges theoretical knowledge with real-world system engineering practice.

