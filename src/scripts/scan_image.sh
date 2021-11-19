#!/usr/bin/env bash
# set -e

function ScanImage() {
    failOnSeverityFlag=""
    if [ -n "$FAIL_ON" ] && [ "$FAIL_ON" != " " ]; then
        failOnSeverityFlag="-f ${FAIL_ON}"
    fi

    if [ -z "$IMAGE_NAME" ]; then
        echo "IMAGE_NAME must be set"
        exit 1
    fi

    if [ -z "$OUTPUT_FORMAT" ]; then
        echo "OUTPUT_FORMAT must be set"
        exit 1
    fi


    curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b . latest
    TRIMMED_IMAGE_NAME=$(echo "$IMAGE_NAME" | tr -s '/.:' '-')
    ./grype "$IMAGE_NAME" -o "$OUTPUT_FORMAT" > "${TRIMMED_IMAGE_NAME}-vuln.json" ${failOnSeverityFlag:+$failOnSeverityFlag}
}

# Will not run if sourced from another script.
# This is done so this script may be tested.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    ScanImage
fi
