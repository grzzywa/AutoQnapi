#!/bin/bash

while [[ true ]]; do
    echo "working"
    if [[ -d /data ]]; then

        cd /data
        echo "searching for video files"
        find -type f \( -name "*.avi" -or -name "*.mkv" -or -name "*.mp4" \) > /data.video.raw.txt;
        echo "searching subtitles" 
        while IFS='' read -r line || [[ -n "$line" ]]; do
            movFile="${line}"
            txtFile="${line::-4}.txt"
            # echo "$movFile"
            echo "$txtFile"
            if [[ ! -a "$txtFile" ]]; then
                qnapi -c -d "$movFile" && echo "downloaded $txtFile"
            fi
            if [[ -a "$txtFile" ]]; then
                if [[ `file -i "$txtFile" | grep "unknown-8bit" >/dev/null 2>&1; echo $?` == 0 ]]; then
                    iconv -f CP1250 -t UTF-8 "$txtFile" -o "$txtFile.tmp" && \
                    mv "$txtFile.tmp" "$txtFile" && \
                    echo "fixed $txtFile"
                fi

            fi
        done < "/data.video.raw.txt"
    else
        echo "data not found"
    fi
    sleep 600
done
