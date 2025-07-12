# 🔐 Linux Permission Scanner Utility

![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)
![Open Source](https://badgen.net/badge/license/MIT/green)

A lightweight Bash tool to **scan, detect, and fix insecure file and directory permissions** on Linux — with dry-run safety, logging, and customization.

---

## 📚 Table of Contents
- [Features](#-features)
- [Usage](#-usage)
- [Screenshots](#-screenshots)
- [Author & Links](#-author--links)
- [License](#-license)

---

## 🚀 Features

- 📁 Scan any target directory (`--target-dir`)
- 🧪 **Dry-run by default** – safe preview mode
- 🛠️ Apply secure fixes using `--fix`
- 📢 Show detailed output with `--verbose`
- 🔧 Set **custom permissions** for files/directories
- 👥 Change **ownership** to a specific user/group
- 📊 Display **disk usage per user**
- 🧾 Auto-generates logs in `/var/log/permission_audit`
- ℹ️ View help menu using `--help`

> 🔐 **Important:** This tool is intended to be run with `sudo` for full functionality and accurate permission changes.

---

## ⚙️ Usage

```bash
# Help menu
./permission_audit.sh --help

# Basic dry-run scan
./permission_audit.sh --target-dir /path/to/folder

# Apply fixes
./permission-audit.sh --target-dir /path/to/folder --fix

# Verbose + Fix
./permission_audit.sh --target-dir /path --fix --verbose

```




## 🌐 Connect with me

<a href="https://www.youtube.com/@HackWithDD" target="_blank">
  <img src="https://cdn.jsdelivr.net/npm/simple-icons@v9/icons/youtube.svg" alt="YouTube" width="30" style="margin-right: 10px;" />
</a>
<a href="https://www.instagram.com/i.diptanshu/" target="_blank">
  <img src="https://cdn.jsdelivr.net/npm/simple-icons@v9/icons/instagram.svg" alt="Instagram" width="30" style="margin-right: 10px;" />
</a>
<a href="https://x.com/DhawanDiptanshu" target="_blank">
  <img src="https://cdn.jsdelivr.net/npm/simple-icons@v9/icons/twitter.svg" alt="Twitter" width="30" style="margin-right: 10px;" />
</a>
<a href="www.linkedin.com/in/diptanshudhawan" target="_blank">
  <img src="https://cdn.jsdelivr.net/npm/simple-icons@v9/icons/linkedin.svg" alt="LinkedIn" width="30" />
</a>




