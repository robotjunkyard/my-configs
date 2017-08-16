#!/bin/bash

BLOCKS=('▁' '▂' '▃' '▄' '▅' '▆' '▇' '█')

round()
{
echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};

current_charge=$(cat /sys/class/power_supply/BAT0/energy_now)
total_charge=$(cat /sys/class/power_supply/BAT0/energy_full)

charged_slots=$(echo "(($current_charge/$total_charge)*7)" | bc -l)
percentage_charge=$(echo "(($current_charge/$total_charge)*100)" | bc -l | cut -c 1-2)
charged_slots=$(round $charged_slots 0)
if [[ $charged_slots -gt 7 ]]; then
  charged_slots=7
fi

echo -n '#[bg=white]'

delta_symbol="↓"
bat_status=$(cat /sys/class/power_supply/BAT0/status)
if [ "$bat_status" == "Charging" ]; then
   delta_symbol="#[fg=colour11]⚡"
   power_color="#[fg=blue]"
else
    if [[ $charged_slots -gt 5 ]] ; then
	power_color='#[fg=colour10]'
    elif [ $charged_slots -gt 4 ] ; then
	power_color='#[fg=colour11]'
    elif [ $charged_slots -gt 2 ] ; then
	power_color='#[fg=colour3]'
    else
	power_color='#[fg=colour9]'
    fi
fi

echo -n "$power_color${BLOCKS[$charged_slots]}#[bg=default,fg=white]$delta_symbol$power_color$percentage_charge%"
