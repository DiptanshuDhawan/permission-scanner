# 🧪 Test Environment Generator

This script (`setup_test_env.sh`) creates a **simulated environment** with deliberately misconfigured files, folders, and users so you can test the **Linux Permission Scanner Utility** without risking real system files.

---

## ⚠️ Warning

> 🚫 **DO NOT run this script on production systems.**
>
> It creates:
> - Files with insecure permissions (e.g., `777`, `666`)
> - Directories with overly permissive access
> - Optionally creates test users and groups (with your permission)

Run it only on:
- Virtual machines
- Local test environments
- Sandboxes

---
