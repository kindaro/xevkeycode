#!/bin/sh

xev |
    grep -o -e 'keycode [0-9]\+' -e '^[a-zA-Z]\+ event' --line-buffered |
    while read token1 token2
    do
        if [ "$token2" == 'event' ]
        then
            case "$token1" in
                ('KeyPress') nextMatters=True ;;
                (*) nextMatters=False ;
            esac
        fi

        if [ "$token1" == 'keycode' ]
        then
            if [ $nextMatters == True ]
            then
                xmodmap -pke |
                grep "keycode[ ]\+$token2 ="
            fi
        fi
    done
