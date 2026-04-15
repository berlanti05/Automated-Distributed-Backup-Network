# Automated Distributed Backup Network

A distributed backup system that automatically creates encrypted backups across multiple network nodes without relying on a central backup server. The system uses secure communication, automation, Docker containers, and a web dashboard.

---

## 👥 Team
- Sara Othman
- Berlanti Masalha


**Course:** Computer Networking  
**Instructor:** Dr. Jehad Hamamreh  
**University:** An-Najah National University  
**Date:** April 2026  

---

# 📌 Project Idea
Traditional backup systems rely on a central server, which causes:
- High cost 💰  
- Single point of failure ⚠️  
- Unused storage in branches  

This project distributes encrypted backups across multiple nodes.

Each node:
- Stores its own data  
- Sends encrypted backups to other nodes  
- Can restore data from any node  

---

# ✨ Features
- Distributed backup system  
- Encryption using OpenSSL 🔒  
- Automated backups using cron ⏰  
- File sync using rsync  
- Compression using tar + gzip  
- Secure communication (SSH + Tailscale)  
- Docker support 🐳  
- Web dashboard (Flask)  
- Monitoring success/failure  

---

# 🛠️ Technologies Used
- Ubuntu  
- VirtualBox  
- Docker  
- Bash  
- SSH  
- rsync  
- OpenSSL  
- cron  
- Python Flask  
- HTML / CSS / JS  
- Chart.js  
- Tailscale  
- GNS3  

---

# 📂 Project Structure
```text
project/
│
├── data/
├── backup/
├── storage/
│
├── scripts/
│   ├── backup.sh
│   └── restore.sh
│
├── docker/
│   ├── Dockerfile
│   └── crontab
│
├── agent/
│   ├── app.py
│   ├── templates/
│   │   └── index.html
│   └── static/
│       ├── style.css
│       └── script.js
│
└── logs/
    └── operations.json
