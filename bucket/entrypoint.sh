#!/bin/bash
 
yum install -y jq
TOKEN=$(aws sts assume-role --role-arn $1 --role-session-name $3)
echo $TOKEN | jq '.Credentials.AccessKeyId'
export AWS_ACCESS_KEY_ID="$(echo $TOKEN | jq '.Credentials.AccessKeyId')"
export AWS_SECRET_ACCESS_KEY="$(echo $TOKEN | jq '.Credentials.SecretAccessKey')"
export AWS_SESSION_TOKEN="$(echo $TOKEN | jq '.Credentials.SessionToken')"
aws sts get-caller-identity

if [[ "$4" == "delete" ]]; then
    aws s3 rm s3://$2/ --recursive --exclude "*" --include "$3/*"
else
    aws s3api put-object --bucket $2 --key $3
fi

echo "::set-output name=bucket::$2"
echo "::set-output name=folder::$3"