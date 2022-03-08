#!/usr/bin/env bash

set -ex

REPOSITORY=$1
COMMIT=$(echo $2 | cut -c-7)
TAG=$3

yum install -y jq
MANIFEST=$(aws ecr batch-get-image --repository-name $REPOSITORY --image-ids imageTag=$COMMIT --output json | jq --raw-output '.images[0].imageManifest')
if [ "$MANIFEST" = "null" ]; then
    exit 1
if

aws ecr batch-delete-image --repository-name $REPOSITORY --image-ids imageTag=$COMMIT | jq -r .
aws ecr put-image --repository-name $REPOSITORY --image-tag $TAG --image-manifest "$MANIFEST" | jq -r .
