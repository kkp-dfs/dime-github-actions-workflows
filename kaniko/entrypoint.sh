#!/busybox/sh

PATH=/usr/local/bin:/kaniko:/busybox

set -e

mkdir -p ~/.docker
cat > ~/.docker/config.json <<EOF
{"auths":{"$1":{"auth":"$2"}}}
EOF
cp ~/.docker/config.json /kaniko/.docker/config.json

DESTINATIONS=$(echo $3 | tr " " "\n" | xargs -I@ echo --destination=@)
BUILD_ARGS=$(echo $4 | tr " " "\n" | xargs -I@ echo --build-arg=@)
LABELS=$(echo $5 | tr " " "\n" | xargs -I@ echo --label=@)

/kaniko/executor \
    --cache \
    --dockerfile=Dockerfile \
    --context=/github/workspace \
    $BUILD_ARGS $DESTINATIONS

echo "::set-output name=image::$3"