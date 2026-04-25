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
