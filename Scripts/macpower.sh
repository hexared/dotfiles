#!/bin/zsh

TOT=0
NOW=0
#POW=0

#if [[ $(cat /sys/class/power_supply/AC/online) -eq 0 ]]; then
if [[ $(pmset -g batt | head -n1 |cut -d"'" -f2|cut -d' ' -f1) -eq "AC" ]]; then
    STAT=🔋
else
    STAT=🔌
fi

printf "[%s%s]" $STAT $(pmset -g batt | tail -n1 | cut -d'	' -f2 | cut -d';' -f1)
