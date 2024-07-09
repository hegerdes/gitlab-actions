#!/bin/sh

set -e
CI_REGISTRY_IMAGE=abc
CI_COMMIT_REF_SLUG=efg

# PRE_COMMIT_AUTO_FIX="true"
# if [[ "$PRE_COMMIT_AUTO_FIX" != "true" ]]; then
#     echo HI
#     exit 1 # fail the job
# fi

# echo "["$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG"]" | yq

# export IMAGE_TAGS='["$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG", "$CI_REGISTRY_IMAGE:latest"]'

FILE=tests/Dockerfile
if [ -f "$FILE" ]; then
    STRING="FROM"
    BASE_IMG=$(grep "$STRING" "$FILE" | tail -n 1 | awk '{print $2}')
    echo "${BASE_IMG}"
else
    echo "File $FILE does not exist."
fi
HOST
# # # Preparing image tags
# # # Remove the brackets and then split the string by commas
# IMAGE_TAGS="${IMAGE_TAGS#[}"
# IMAGE_TAGS="${IMAGE_TAGS%]}"

# # # Read the cleaned-up string into an array, splitting by commas
# IFS=","
# for IMAGE_TAG in ${IMAGE_TAGS}; do
#     # Ensure to strip any whitespace and send a curl request to each URL
#     echo $IMAGE_TAG
#     CONTAINER_BUILD_IAMGE_TAGS="${CONTAINER_BUILD_IAMGE_TAGS}--destination $(echo $IMAGE_TAG | xargs) "
# done
# # echo $CONTAINER_BUILD_IAMGE_TAGS

# buildah build $CONTAINER_BUILD_IAMGE_TAGS \
#     --layers --sbom preset \
#     --file $DOCKERFILE \
#     --build-arg COMMIT_HASH=$CI_COMMIT_SHORT_SHA \
#     --build-arg COMMIT_TAG=$CI_COMMIT_REF_NAME \
#     --build-arg BUILD_ENV=$BUILD_ENV \
#     --label org.opencontainers.image.created="$(date --iso-8601=minutes)" \
#     --label org.opencontainers.image.authors="${AUTHORS}" \
#     --label org.opencontainers.image.url="${PROJECT_URL}" \
#     --label org.opencontainers.image.documentation="${documentation_url}" \
#     --label org.opencontainers.image.source="${SOURCE_URL}" \
#     --label org.opencontainers.image.version="${VERSION}" \
#     --label org.opencontainers.image.revision="${CI_COMMIT_SHORT_SHA}" \
#     --label org.opencontainers.image.vendor="${VENDOR}" \
#     --label org.opencontainers.image.licenses="${LICENSE}" \
#     --label org.opencontainers.image.title="$BUILD_IMAGE_TAG" \
#     --label org.opencontainers.image.description="$DESCRIPTION" \
#     --label org.opencontainers.image.base.name="${BASE_IMG_NAME}" \
#     $CONTEXT

# --label org.opencontainers.image.created="$(date --iso-8601=minutes)" \
#     --label org.opencontainers.image.authors="${AUTHORS}" \
#     --label org.opencontainers.image.url="${PROJECT_URL}" \
#     --label org.opencontainers.image.documentation="${documentation_url}" \
#     --label org.opencontainers.image.source="${SOURCE_URL}" \
#     --label org.opencontainers.image.version="${VERSION}" \
#     --label org.opencontainers.image.revision="${CI_COMMIT_SHORT_SHA}" \
#     --label org.opencontainers.image.vendor="${VENDOR}" \
#     --label org.opencontainers.image.licenses="${LICENSE}" \
#     --label org.opencontainers.image.title="$BUILD_IMAGE_TAG" \
#     --label org.opencontainers.image.description="$DESCRIPTION" \
#     --label org.opencontainers.image.base.name="${BASE_IMG_NAME}"
