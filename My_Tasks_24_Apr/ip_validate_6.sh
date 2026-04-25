# Create a shell script that validates an IPv4 address entered by the user.

# The script should prompt the user to enter an IP address.
# It should check that the IP has exactly four octets separated by dots.
# Each octet must be a number between 0 and 255.
# If the IP is valid, display "IP is valid", otherwise display "IP is not valid".
# After each validation, prompt the user to either continue or type 'q' to quit.
# Keep looping until the user chooses to quit.
# ..............................................................................................................


#!/bin/bash

while true
do
    read -p "Enter IP address: " ip

    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        valid=true

        IFS='.' read -r a b c d <<< "$ip"
        for i in $a $b $c $d
        do
            if (( i < 0 || i > 255 )); then
                valid=false
                break
            fi
        done

        if $valid; then
            echo "IP is valid"
        else
            echo "IP is not valid"
        fi
    else
        echo "IP is not valid"
    fi

    read -p "Press Enter to continue or 'q' to quit: " choice
    [[ $choice == "q" ]] && break
done
