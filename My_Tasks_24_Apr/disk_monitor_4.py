import subprocess

THRESHOLD = 80  
result = subprocess.run(["df", "-h", "/"], capture_output=True, text=True)

lines = result.stdout.split("\n")
disk_info = lines[1].split()

usage = int(disk_info[4].replace("%", ""))

print("Disk Usage:", usage, "%")

if usage > THRESHOLD:
    print("WARNING: Disk usage is high!")

    with open("disk_alerts.log", "a") as f:
        f.write(f"WARNING: Disk usage is {usage}% (threshold: {THRESHOLD}%)\n")
