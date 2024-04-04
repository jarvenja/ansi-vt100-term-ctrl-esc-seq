#!/bin/bash
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
#      Palette for ANSI/VT100 Terminal Control Escaped Sequences
#           Copyright (c) 2024 <janne.jarvenpaa@gmail.com>
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#

bg256 () {
    local w
    w=3
    echo -en "\e[38;5;0m"
    for col in {0..255}; do
        echo -en "\e[48;5;${col}m$(printf "%${w}s" ${col})"
        case $col in
            7)  echo -en "\e[0m";
                echo "          ctrl seq: \e[48;5;\${N}m"
                echo -en "\e[38;5;0m"
                ;;
            15) echo -en "\e[97m\n";
                w=4
                ;;
        esac
    done
}

commonColors () { # numbers...
    for n in "$@"; do
        echo -en "\e[${n}m$(printf "%4s" ${n})"
    done
    reset
}

ensureBash () {
    local x
    x=$(getShellType)
    [ "$x" != "bash" ] && fatal "Must be run by bash instead of $x"
}

fatal () { # msg
    echo "Fatal Error: ${1}" >&2
    exit 1
}

fg256 () {
    for col in {0..255}; do
        echo -en "\e[38;5;${col}m$(printf "%4s" ${col})"
        case $col in
            7) echo "  ctrl seq: \e[38;5;\${N}m               " ;;
            15) echo "                                        " ;;
        esac
    done
}

formattingAnd16colors () {
    echo "set        reset                  ctrl seq: \e\${N}m"
    echo -e "1    \e[1mbold\e[0m    21" # <- a bug?
    echo -e "2     \e[2mdim\e[22m    22 $(commonColors {30..37})       Palette for"
    echo -e "4 \e[4munderlined\e[24m 24 $(commonColors {40..47})   ANSI/VT100 Terminal"
    echo -e "5   \e[5m*blink*\e[25m  25 $(commonColors {90..97})     Control Escape"
    echo -e "7  \e[7mreversed\e[27m  27 $(commonColors {100..107})        Sequences"
    echo -e "8   \e[8mhidden\e[28m   28 \e[2m<--- hidden\e[22m"
}

getShellType () {
    local x
    x=$(ps -p $$)
    echo "${x##* }"
}

reset () {
    echo -en "\e[0m"
}

ensureBash
readonly VER="v0.1"
clear
reset
formattingAnd16colors
echo -e "\e[2m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> when width is 144 sweetspot is here!\e[22m"
fg256
echo
bg256
echo
reset
