#!/bin/bash

set -x
if [[ $BASH_ARGC -lt 1 ]]; then
    echo "$0 <BMC_IP>"
    echo $BASH_ARGC
    exit 1
fi

ipmitool -I lanplus -H $1 -U admin -P admin sol activate
