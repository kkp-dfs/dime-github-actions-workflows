#!/usr/bin/env bash

set -e

REPOSITORY=$1
CURRENT=$2
TAG=$3

MANIFEST=$(aws ecr batch-get-image --repository-name $REPOSITORY --image-ids imageTag=$CURRENT --output json | jq --raw-output '.images[0].imageManifest')
aws ecr batch-delete-image --repository-name $REPOSITORY --image-ids imageTag=$TAG | jq -r .
aws ecr put-image --repository-name $REPOSITORY --image-tag $TAG --image-manifest "$MANIFEST" | jq -r .
