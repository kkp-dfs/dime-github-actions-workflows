#!/busybox/sh

cp -R ~/.docker/config.json /kaniko/.docker/config.json

/kaniko/executor \
    --cache \
    --dockerfile=Dockerfile \
    --destination=$1

echo "::set-output name=image::$1"
