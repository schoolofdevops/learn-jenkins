#!/bin/bash

if [ -e /var/run/docker.sock  ]
then
  sudo chgrp jenkins /var/run/docker.sock
fi

# Call Jenkins.sh from original repo, which in turn runs CMD using exec "$@"
/usr/local/bin/jenkins.sh

