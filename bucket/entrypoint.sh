#!/bin/bash
 
yum install -y jq
TOKEN=$(aws sts assume-role --role-arn $1 --role-session-name $3)
export AWS_ACCESS_KEY_ID="$(echo $TOKEN | jq -r '.Credentials.AccessKeyId')"
export AWS_SECRET_ACCESS_KEY="$(echo $TOKEN | jq -r '.Credentials.SecretAccessKey')"
export AWS_SESSION_TOKEN="$(echo $TOKEN | jq -r '.Credentials.SessionToken')"

if [[ "$4" == "delete" ]]; then
    aws s3 rm s3://$2/ --recursive --exclude "*" --include "$3/*"
else
    aws s3api put-object --bucket $2 --key $3
fi

echo "::set-output name=bucket::$2"
echo "::set-output name=folder::$3"