#!/bin/zsh

NET=""

if [[ "$(ps -p $(pidof tmux | cut -d" " -f2) -o etime= | cut -d' ' -f7)" = "00:00" ]]; then
    echo "🌐 Checking connection..."
fi

function main(){
    if [[ -n $(ping -c1 8.8.8.8 | grep ttl) ]]; then
        CSV=$(speedtest-cli --simple)
        UP=$(echo $CSV | tail -n1 | cut -d":" -f2 | cut -d" " -f2) || "-"
        DL=$(echo $CSV | tail -n2 | head -n1 | cut -d":" -f2 | cut -d" " -f2) || "-"
        PN=$(echo $CSV | head -n1 | cut -d":" -f2 | cut -d" " -f2) || "-"
        NET="🔻$DL | 🔺$UP | 🏓$PN[1,5]"
    else
        NET="❌ No internet connection"
    fi
    echo $NET
}

main
