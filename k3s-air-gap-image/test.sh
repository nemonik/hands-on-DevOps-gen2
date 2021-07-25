#!/usr/bin/env bash

set -a

skip_encrypted_variables=true

. ../.env




if ! [[ "50" =~ ^[0-9]+$ ]]; then
        echo "Sorry integers only"
else
	echo "integer"
fi

  IFS=':' read -ra parts <<< "k3d-registry.nemonik.com:5000/nemonik/k3s:v1.21.2-k3s1"

  if [ ${#parts[@]} == 1 ]; then
    ## no tag, so return the messaged value
    ##
    echo $1
  elif [ ${#parts[@]} == 2 ]; then
    ## handle drone:2.0
    ##
    echo "${parts[0]}"
  elif [ ${#parts[@]} == 3 ]; then

    ## handle docker.io/nemonik/drone:2.0 and docker.io:5000/nemonik/drone:2.0
    ##
    IFS='/' read -ra parts <<< "${parts[1]}"
	    
    echo "-->${parts[0]}<---"
    if [[ "${parts[0]}" =~ "^[0-9]+$" ]]; then
      # remove port if it exists from parts array
      unset parts[0];
      echo "removed"
    fi

    turd="${parts[0]}"

    [[ $turd =~ ^[0-9]{8}$ ]] && unset parts[0]

    # combine all the parts
    name=$(printf "/%s" "${parts[@]}")
    name=${name:1}

    echo "${name}"
  fi
