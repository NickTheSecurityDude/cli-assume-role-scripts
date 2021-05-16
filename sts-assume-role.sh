#!/bin/bash

echo "Usage: source sts-assume-role.sh <role> (<external-id>)"

if [[ $1 = '' ]];then
  exit
fi

ROLE=$1
EXT_ID=$2

ASSUME_FILE=assume-output.txt

if [[ $EXT_ID = '' ]];then
  aws sts assume-role --role-arn $ROLE --role-session-name assumed-role-session >$ASSUME_FILE
else
  aws sts assume-role --role-arn $ROLE --role-session-name assumed-role-session --external-id $EXT_ID >$ASSUME_FILE
fi
export AWS_ACCESS_KEY_ID=`cat $ASSUME_FILE |jq -r .Credentials.AccessKeyId`
export AWS_SECRET_ACCESS_KEY=`cat $ASSUME_FILE |jq -r .Credentials.SecretAccessKey`
export AWS_SESSION_TOKEN=`cat $ASSUME_FILE |jq -r .Credentials.SessionToken`
rm -f $ASSUME_FILE
aws sts get-caller-identity
