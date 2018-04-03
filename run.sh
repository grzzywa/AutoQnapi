export LANG=pl_PL.UTF-8
export LANGUAGE=pl_PL.UTF-8
export LC_CTYPE="pl_PL.UTF-8"
export LC_NUMERIC="pl_PL.UTF-8"
export LC_TIME="pl_PL.UTF-8"
export LC_COLLATE="pl_PL.UTF-8"
export LC_MONETARY="pl_PL.UTF-8"
export LC_MESSAGES="pl_PL.UTF-8"
export LC_PAPER="pl_PL.UTF-8"
export LC_NAME="pl_PL.UTF-8"
export LC_ADDRESS="pl_PL.UTF-8"
export LC_TELEPHONE="pl_PL.UTF-8"
export LC_MEASUREMENT="pl_PL.UTF-8"
export LC_IDENTIFICATION="pl_PL.UTF-8"




while [[ true ]]; do
    if [[ -d /data ]]; then

        cd /data
        find -type f \( -name "*.avi" -or -name "*.mkv" -or -name "*.mp4" \) > /data.video.raw.txt;

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
    fi
    sleep 600
done
