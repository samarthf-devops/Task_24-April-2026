# 1) Find top 5 memory-consuming processes
ps aux --sort=-%mem | head -n 6 

# 2) Find files >100MB in /var/log
find /var/log -type f -size +100

# 3) Count number of .log files recursively
find / -type f -name "*.log" 2>/dev/null | wc -l

# 4) Check if a process is running (e.g., nginx)
pgrep nginx

# 5) Print last 50 lines of a log and filter 'ERROR';
tail -n 50 /path/to/logfile | grep "Error"
