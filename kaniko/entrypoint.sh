#!/busybox/sh

PATH=/usr/local/bin:/kaniko:/busybox

set -e

cat > /kaniko/.docker/config.json <<EOF
{"auths":{"$1":{"auth":"$2"}}}
EOF

DESTINATIONS=$(echo $3 | tr " " "\n" | xargs -I@ echo --destination=@)
BUILD_ARGS=$(echo $4 | tr " " "\n" | xargs -I@ echo --build-arg=@)
LABELS=$(echo $5 | tr " " "\n" | xargs -I@ echo --label=@)
DOCKERFILE=$(echo $6 | xargs -I@ echo --dockerfile=@)
TARGET=$(echo $7 | xargs -I@ echo --target=@)

/kaniko/executor \
    --context=$PWD \
    --cache \
    --use-new-run \
    --snapshotMode=redo \
    --compressed-caching=false \
    $BUILD_ARGS $DOCKERFILE $TARGET $DESTINATIONS

echo "::set-output name=image::$3"
