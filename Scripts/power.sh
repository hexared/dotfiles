#!/bin/zsh

TOT=0
NOW=0
#POW=0

if [[ $(cat /sys/class/power_supply/AC/online) -eq 0 ]]; then
    STAT=🔋
else
    STAT=🔌
fi

for VAL in $(cat /sys/class/power_supply/BAT*/energy_full); do
    TOT=$(( $TOT + $VAL ))
done

for VAL in $(cat /sys/class/power_supply/BAT*/energy_now); do
    NOW=$(( $NOW + $VAL ))
done

#for VAL in $(cat /sys/class/power_supply/BAT*/power_now); do
#    POW=$(( $POW + $VAL ))
#done

#TIME=$(( ($NOW+0.0 / $POW )/10000000.0 ))
#H=$(($TIME + (($TIME - $TIME/1)/60) ))
#R=$(($TIME))
#printf "%d %f" $H $R
#printf "%s%.1f%% | %.2fh\n" $STAT $(( ($NOW * 100.00) / $TOT)) $(( ($NOW+0.0 / $POW+0.0 )/1000
printf "[%s%.1f%%]" $STAT $(( ($NOW * 100.00) / $TOT))
