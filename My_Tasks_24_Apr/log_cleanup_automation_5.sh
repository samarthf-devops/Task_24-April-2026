# Task 5: Log Cleanup Automation
# Write a script to:
# - Compress logs older than 2 days
# - Delete logs older than 7 days
# .....................................................................

/var/log/myapp/*.log {
    daily
    rotate 7               
    compress               
    delaycompress          
    missingok              
    notifempty             
    create 0640 root root  
    dateext                
}
