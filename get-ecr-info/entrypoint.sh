#!/bin/bash

REPOSITORY=$(aws ecr describe-repositories --region ap-southeast-1 --output text \
--query 'repositories[].repositoryUri' --repository-name "$1")

TOKEN=$(aws ecr get-authorization-token \
    --region ap-southeast-1 --output text \
    --query 'authorizationData[].authorizationToken' | base64 -d)

echo "::set-output name=token::$TOKEN"
echo "::set-output name=repository::$REPOSITORY"
echo "::set-output name=username::$(echo $TOKEN | cut -d: -f1)"
echo "::set-output name=password::$(echo $TOKEN | cut -d: -f2)"