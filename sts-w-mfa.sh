#!/bin/bash

echo "Usage: source sts-w-mfa.sh <token-code>"

if [[ $1 = '' ]];then
  exit
fi

TOKEN_CODE=$1

echo $TOKEN_CODE

TOKEN_FILE=token-output.txt

MFA_ARN=`aws sts get-caller-identity | jq -r .Arn |sed "s/:user\//:mfa\//"`

aws sts get-session-token --serial-number $MFA_ARN --token-code $TOKEN_CODE >$TOKEN_FILE
export AWS_ACCESS_KEY_ID=`cat $TOKEN_FILE |jq -r .Credentials.AccessKeyId`
export AWS_SECRET_ACCESS_KEY=`cat $TOKEN_FILE |jq -r .Credentials.SecretAccessKey`
export AWS_SESSION_TOKEN=`cat $TOKEN_FILE |jq -r .Credentials.SessionToken`
rm -f $TOKEN_FILE
aws sts get-caller-identity
echo $AWS_ACCESS_KEY_ID
