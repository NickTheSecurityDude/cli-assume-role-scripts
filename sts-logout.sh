#!/bin/bash

echo "Usage: source sts-logout.sh"

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_PROFILE

# added 5/18/21
aws sso logout

echo "Logout Script Complete"
