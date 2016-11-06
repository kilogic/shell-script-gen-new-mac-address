#!/bin/bash

#Some distros restrict to changing addresses that follow the following convention: 
#x2-xx-xx-xx-xx-xx
#x6-xx-xx-xx-xx-xx
#xA-xx-xx-xx-xx-xx
#xE-xx-xx-xx-xx-xx

#get 12 character hexadecimal string
NEW_UID=$(cat /dev/urandom | tr -dc '0-9A-F' | fold -w 12 | head -n 1)
#echo $NEW_UID

#add colon delimiters after every two carachters except for last pair
DELIMETED_UID=$(echo $NEW_UID | sed 's/\(.\{2\}\)/&:/g' | sed '$s/.$//')
#echo $DELIMETED_UID

#generate a 2, 6, A, or E
VALID_SECOND_CHARACTER=$(cat /dev/urandom | tr -dc '26AE' | fold -w 1 | head -n 1)
#echo $VALID_SECOND_CHARACTER

#replace second character of the delimeted unique id for one of the allowed ones (use double quotes in the sed command's expression to interpolate the variable's value
VALID_MAC_ADDRESS=$(echo $DELIMETED_UID | sed "s/\(^.\)\([0-9A-F]\)/\1$VALID_SECOND_CHARACTER/")
echo $VALID_MAC_ADDRESS
