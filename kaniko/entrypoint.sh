#!/busybox/sh

cp -R ~/.docker/config.json /kaniko/.docker/config.json

DESTINATIONS=$(echo $1 | tr " " "\n" | xargs -I@ echo --destination=@)
BUILD_ARGS=$(echo $2 | tr " " "\n" | xargs -I@ echo --build-arg=@)
LABELS=$(echo $3 | tr " " "\n" | xargs -I@ echo --label=@)

echo "::set-output name=image::$1"

/kaniko/executor \
    --cache \
    --dockerfile=Dockerfile \
    --context=/github/workspace \
    $BUILD_ARGS $DESTINATIONS

echo $?