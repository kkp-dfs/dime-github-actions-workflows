#!/busybox/sh

cp -R ~/.docker/config.json /kaniko/.docker/config.json

DESTINATIONS=$(echo $1 | sed -e "s| | --destination=|g")
LABELS=$(echo $2 | sed -e "s| | --label=|g")

/kaniko/executor \
    --cache \
    --dockerfile=Dockerfile \
    --destination=$DESTINATIONS

echo "::set-output name=image::$1"
