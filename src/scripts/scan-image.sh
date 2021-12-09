#!/usr/bin/env bash
set -e

function ScanImage() {
    if [ -n "$FAIL_ON" ] && [ "$FAIL_ON" != " " ]; then
        failOnSeverityFlag="-f ${FAIL_ON}"
    fi

    # NOTE: condition passes if DEBUG_LOGS is not false
    if [ "$ENABLE_VERBOSE_LOGS" != "0" ]; then
        echo "debug logs enabled"
        debugFlag="-vv"
    fi

    if [ -z "$IMAGE_NAME" ]; then
        echo "IMAGE_NAME must be set"
        exit 1
    fi

    if [ -z "$OUTPUT_FORMAT" ]; then
        echo "OUTPUT_FORMAT must be set"
        exit 1
    fi

    curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b . "$GRYPE_VERSION"
    ./grype "$IMAGE_NAME" -o "$OUTPUT_FORMAT" > "${OUTPUT_FILE}" ${failOnSeverityFlag:+$failOnSeverityFlag} ${debugFlag:+$debugFlag}
}