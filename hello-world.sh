#!/bin/bash
echo H
printf "\033[A\033[C\145"
printf l | sed -Ee "s/(l)/\1\1/" | tr -d '\n'
echo -n o\ 
printf dlroW | rev | xargs echo -n
echo !
