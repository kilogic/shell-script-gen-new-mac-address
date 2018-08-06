#!/bin/bash

# Universal vs Locally administerd
# Some distros only allow the following (locally administered) address convention:
# x2-xx-xx-xx-xx-xx
# x6-xx-xx-xx-xx-xx
# xA-xx-xx-xx-xx-xx
# xE-xx-xx-xx-xx-xx


usage() {
  echo "Usage: $0 [-h] | [-u] [-d '<string>' | -d \"<string>\"]" 1>&2
  exit 1
}

helptext() {
  usage
}

get_new_uid() {
  # get 12 character hexadecimal string
  cat /dev/urandom | tr -dc '0-9A-F' | fold -w 12 | head -n 1
}

while getopts ":hud:" opt; do
  case "${opt}" in
    h)
      helptext
      ;;
    u)
      UAA=true
      ;;
    d)
      echo "Delimiter '${OPTARG}' will be used"
      DELIMIT=true
      DELIMITER="${OPTARG}"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
  esac
done

TWELVE_CHAR_HEX_UID=$( get_new_uid )

# UAA or LAA (default)
if [ ! "${UAA}" == true ]; then

  echo "A locally administered address (LAA) will be generaged. (default)"

  # generate a 2, 6, A, or E 
  LAA_SECOND_CHARACTER=$(cat /dev/urandom | tr -dc '26AE' | fold -w 1 | head -n 1)

  # replace second character of the delimeted unique id for one of the allowed ones
  # (use double quotes in the sed command's expression to interpolate the variable's value)
  LAA_UID=$(echo "${TWELVE_CHAR_HEX_UID}" | sed "s/\(^.\)\([0-9A-F]\)/\1${LAA_SECOND_CHARACTER}/")
  
  MAC_ADDRESS="${LAA_UID}"
else

  echo "A universally administered address (UAA) may be generated."
  MAC_ADDRESS="${TWELVE_CHAR_HEX_UID}"
fi

if [ "${DELIMIT}" ]; then
  # add delimiter after every two carachters except for last pair
  
  # TODO - '$s/.$//' to double quotes "$s/.$//" will break
  MAC_ADDRESS=$(echo "${MAC_ADDRESS}" | sed "s/\(.\{2\}\)/&${DELIMITER}/g" | sed '$s/.$//')
fi

echo "${MAC_ADDRESS}"

exit

