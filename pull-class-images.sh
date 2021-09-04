#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a

skip_encrypted_variables=true

. .env

if [ "${pullthrough_registry_enabled}" = "true" ]; then

  notify "Pulling class images..."
  images_into_registry class_images

else

  notify "Pullthrough registry not enabled."

fi

notify "Done."
