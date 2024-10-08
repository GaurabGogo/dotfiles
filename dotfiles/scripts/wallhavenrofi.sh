#!/bin/bash

walldir="$HOME/pix/save"
maxpage=5
tagoptions="minimalism\nCyberpunk 2077\nfantasy girl\ndigital art\nanime\n4K\nnature"
if [ -z $1 ]; then
    query=$(echo -e $tagoptions | rofi -dmenu -p "Search Wallhaven:" -i)
else
    query=$1
fi

sortoptions="date_added\nrelevance\nrandom\nviews\nfavorites\ntoplist"
sorting=$(echo -e $sortoptions | rofi -dmenu -p "Sort Order:" -i)

query=$(echo $query | sed 's/ /+/g')
echo $query

notify-send "Downloading wallpapers"
total_files=0
for i in $(seq 1 $maxpage); do
    curl -s "https://wallhaven.cc/api/v1/search?atleast=1920x1080&sorting=$sorting&q=$query&page=$i" > tmp.txt
    urls=$(jq -r '.data[].path' tmp.txt)  # Extract URLs
    num_urls=$(echo "$urls" | wc -l)  # Count number of URLs
    total_files=$((total_files + num_urls))
    for url in $urls; do
        wget -nc -P $walldir "$url"
        total_files=$((total_files - 1))
        notify-send "Remaining Page: $((maxpage - i)) Remaining wallpapers: $total_files"
    done
done
rm tmp.txt
notify-send "Download finished"
nsxiv -t $walldir/*
mv $walldir/* ~/pix/wall/

