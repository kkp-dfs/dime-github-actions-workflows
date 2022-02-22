#!/bin/bash

TOKEN=$(aws ecr get-authorization-token \
    --region ap-southeast-1 --output text \
    --query 'authorizationData[].authorizationToken' | base64 -d)

echo "::add-mask::$TOKEN"
echo "::set-output name=username::$(echo $TOKEN | cut -d: -f1)"
echo "::set-output name=password::$(echo $TOKEN | cut -d: -f2)"