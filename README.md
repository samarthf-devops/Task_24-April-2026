# Linux Administration & Shell Scripting Tasks

A collection of Linux system administration scripts covering process monitoring, service management, log analysis, disk usage, log cleanup, and input validation.

---

## Repository Structure

```
├── linux_task_1.sh                # Top memory processes & log file utilities
├── service_monitor_2.sh           # Task 2 – Service monitor with auto-restart
├── log_analyzer_script_3.sh       # Task 3 – Log file analyzer
├── disk_monitor_4.py              # Task 4 – Disk usage monitor (Python)
├── log_cleanup_automation_5.sh    # Task 5 – Log rotation config
├── ip_validate_6.sh               # Task 6 – IPv4 address validator
└── README.md
```

---

## Task Overview

### Task 1 – System Monitoring Commands
A set of one-liner shell commands to quickly inspect system health:
- View the top 5 memory-consuming processes
- Find files larger than 100MB inside `/var/log`
- Count all `.log` files on the system recursively
- Check whether a specific process (e.g. nginx) is running
- Tail the last 50 lines of a log file and filter for `ERROR` entries

**How to run:**
```bash
bash linux_task_1.sh  
```

---

### Task 2 – Service Monitor (`service_monitor2.sh`)
Checks if a given system service is running. If it is not, the script will automatically attempt to restart it up to 3 times, logging every action with a timestamp.

**How to run:**
```bash
bash service_monitor2.sh
```

**Exit codes:**
| Code | Meaning |
|------|---------|
| `0` | Service is running or was successfully restarted |
| `2` | Service failed to restart after all retries |

**Log file:** `/tmp/service_monitor.log`

**Sample log output:**
```
<img width="483" height="131" alt="image" src="https://github.com/user-attachments/assets/94822fb4-2d31-4859-af8c-4e3e980bc364" />

```

---

### Task 3 – Log Analyzer (`log_analyzer_script_3.sh` )
Parses a log file and counts the total number of `ERROR` and `INFO` entries. Also shows the top 3 most frequently occurring error messages.

**How to run:**
```bash
bash log_analyzer_script_3.sh  /var/log/syslog
```

**Sample output:**
```
<img width="1285" height="225" alt="image" src="https://github.com/user-attachments/assets/138fccd4-1397-4271-908c-9d8c904b1e22" />

```

---

### Task 4 – Disk Usage Monitor (`disk_monitor_4.py`)
A Python script that checks the current disk usage of the root partition (`/`). If usage exceeds 80%, it prints a warning to the terminal and appends the alert to `disk_alerts.log`.

**Requirements:** Python 3

**How to run:**
```bash
python3 disk_monitor_4.py  
```

**Sample output:**
```
<img width="616" height="69" alt="image" src="https://github.com/user-attachments/assets/fe001c33-8e47-4ba7-8a88-296029ac9599" />

```

**Alert log file:** `disk_alerts.log` (created in the same directory)

---

### Task 5 – Log Rotation (`og_cleanup_automation_5.sh `)

A `logrotate` configuration file that automatically manages log files in `/var/log/myapp/`:

- Rotates logs **daily**
- Keeps the last **7 rotations**
- **Compresses** old logs (with a one-day delay to avoid compressing the most recent)
- Adds a **date stamp** to rotated file names
- Skips rotation if the log file is empty

---

#### How to Apply (Manual)

```bash
# Test the config first (dry run – nothing gets changed)
sudo logrotate --debug /path/to/logrotate_myapp.conf

# Force run it manually
sudo logrotate -f /path/to/logrotate_myapp.conf
```

---

#### Automate with systemd Timer

 use a **systemd timer** to run logrotate automatically every day.

**Step 1 – Copy the config to logrotate.d**

```bash
sudo cp logrotate_myapp.conf /etc/logrotate.d/myapp
```

**Step 2 – Create the service unit**

Create file: `/etc/systemd/system/logrotate-myapp.service`

```ini
[Unit]
Description=Rotate myapp logs using logrotate

[Service]
Type=oneshot
ExecStart=/usr/sbin/logrotate /etc/logrotate.d/myapp
```

**Step 3 – Create the timer unit**

Create file: `/etc/systemd/system/logrotate-myapp.timer`

```ini
[Unit]
Description=Run myapp logrotate daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```

> `Persistent=true` — if the system was off at the scheduled time, the timer will run immediately on next boot.

**Step 4 – Enable and start the timer**

```bash
sudo systemctl daemon-reload
sudo systemctl enable logrotate-myapp.timer
sudo systemctl start logrotate-myapp.timer
```

**Step 5 – Verify the timer is active**

```bash
systemctl list-timers --all | grep logrotate-myapp
```

output like:
```
NEXT                        LEFT     LAST                        PASSED  UNIT                        ACTIVATES
Sat 2026-04-26 00:00:00 IST 10h left Fri 2026-04-25 00:00:01 IST 13h ago logrotate-myapp.timer       logrotate-myapp.service
```

**Step 6 – Check logs to confirm it ran**

```bash
sudo journalctl -u logrotate-myapp.service
```

---

### Task 6 – IPv4 Address Validator (`validate_ip.sh`)
An interactive script that prompts the user to enter an IPv4 address and validates it in a loop until the user quits.

**Validation rules:**
- Must have exactly 4 octets separated by dots
- Each octet must be a number between `0` and `255`

**How to run:**
```bash
bash validate_ip.sh
```

**Sample interaction:**
```
Enter IP address: 192.168.1.1
IP is valid
Press Enter to continue or 'q' to quit:

Enter IP address: 999.0.0.1
IP is not valid
Press Enter to continue or 'q' to quit: q
```

---

