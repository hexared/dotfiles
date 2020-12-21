#!/bin/zsh

M=$(date +\%M)
H=$(date +\%H)

if [ $H -eq 00 ] || [ $H -eq 12 ]; then
    if [ $M -gt 29 ]; then
        echo "🕧 $H:$M"
    else
        echo "🕛$H:$M"
    fi
elif [ $H -eq 01 ] || [ $H -eq 13 ]; then
    if [ $M -gt 29 ]; then
        echo "🕜$H:$M"
    else
        echo "🕐$H:$M"
    fi
elif [ $H -eq 02 ] || [ $H -eq 14 ]; then
    if [ $M -gt 29 ]; then
        echo "🕝$H:$M"
    else
        echo "🕑$H:$M"
    fi
elif [ $H -eq 03 ] || [ $H -eq 15 ]; then
    if [ $M -gt 29 ]; then
        echo "🕞$H:$M"
    else
        echo "🕒$H:$M"
    fi
elif [ $H -eq 04 ] || [ $H -eq 16 ]; then
    if [ $M -gt 29 ]; then
        echo "🕟$H:$M"
    else
        echo "🕓$H:$M"
    fi
elif [ $H -eq 05 ] || [ $H -eq 17 ]; then
    if [ $M -gt 29 ]; then
        echo "🕠$H:$M"
    else
        echo "🕔$H:$M"
    fi
elif [ $H -eq 06 ] || [ $H -eq 18 ]; then
    if [ $M -gt 29 ]; then
        echo "🕡$H:$M"
    else
        echo "🕕$H:$M"
    fi
elif [ $H -eq 07 ] || [ $H -eq 19 ]; then
    if [ $M -gt 29 ]; then
        echo "🕢$H:$M"
    else
        echo "🕖$H:$M"
    fi
elif [ $H -eq 08 ] || [ $H -eq 20 ]; then
    if [ $M -gt 29 ]; then
        echo "🕣$H:$M"
    else
        echo "🕗$H:$M"
    fi
elif [ $H -eq 09 ] || [ $H -eq 21 ]; then
    if [ $M -gt 29 ]; then
        echo "🕤$H:$M"
    else
        echo "🕘$H:$M"
    fi
elif [ $H -eq 10 ] || [ $H -eq 22 ]; then
    if [ $M -gt 29 ]; then
        echo "🕥$H:$M"
    else
        echo "🕙$H:$M"
    fi
elif [ $H -eq 11 ] || [ $H -eq 23 ]; then
    if [ $M -gt 29 ]; then
        echo "🕦$H:$M"
    else
        echo "🕚$H:$M"
    fi
fi
