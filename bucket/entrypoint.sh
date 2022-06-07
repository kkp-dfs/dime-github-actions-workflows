#!/bin/bash

if [[ "$3" == "delete" ]]; then
    aws s3 rm s3://$1/ --recursive --exclude "*" --include "$2/*"
else
    aws sts get-caller-identity
    aws s3api put-object --bucket $1 --key $2
fi

echo "::set-output name=bucket::$1"
echo "::set-output name=folder::$2"