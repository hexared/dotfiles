#!/bin/zsh


if [[ "$(ps -p $(pidof tmux | cut -d" " -f2) -o etime= | cut -d' ' -f7)" = "00:00" ]]; then
    echo "🌐 Checking connection..."
fi

function main(){
    if [[ -n $(ping -c1 8.8.8.8 | grep ttl) ]]; then
        CSV=$(speedtest-cli --csv)
        #IP=$(echo $CSV | cut -d',' -f10)
        UP=$(echo $CSV | cut -d',' -f8)
        UP=$(echo "$UP[1,2].$UP[3,4]")
        DL=$(echo $CSV | cut -d',' -f7)
        DL=$(echo "$DL[1,2].$DL[3,4]")
        PN=$(echo $CSV | cut -d',' -f6)
        #echo "🌐$IP | 🔻$DL | 🔺$UP | 🏓 $PN[1,4]"
        echo "🔻$DL | 🔺$UP | 🏓 $PN[1,4]"
    else
        echo "❌ No internet connection"
    fi
}

main
