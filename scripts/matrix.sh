#!/bin/bash
echo -e "\e[1;32m"
trap "tput cnorm; clear; exit" SIGINT SIGTERM
tput civis
while true; do
  for i in {1..20}; do
    line=""
    for j in {1..40}; do
      rand=$((RANDOM % 2))
      if [ $rand -eq 1 ]; then
        char=$(echo "$RANDOM" | md5sum | cut -c1)
        line+="$char "
      else
        line+="  "
      fi
    done
    echo "$line"
    sleep 0.05
  done
  sleep 0.1
  clear
done
