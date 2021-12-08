#!/usr/bin/env bash
set -e

function ScanImage() {
    failOnSeverityFlag=""
    if [ -n "$FAIL_ON" ] && [ "$FAIL_ON" != " " ]; then
        failOnSeverityFlag="-f ${FAIL_ON}"
    fi

    # NOTE: condition passes if DEBUG_LOGS is not false
    if [ "$ENABLE_DEBUG_LOGS" != "0" ]; then
        # echo "debug logs enabled"
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

    case $OUTPUT_FORMAT in
        json | JSON)
            OUTPUT_FILE_FORMAT="json"
            ;;
        cyclonedx | cyclonedx-xml)
            OUTPUT_FILE_FORMAT="xml"
            ;;
        table)
            OUTPUT_FILE_FORMAT="tsv"
            ;;
        *)
            printf "unknown output format '%s'\n" "$OUTPUT_FORMAT"
            return 1
            ;;
    esac

    curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b . $GRYPE_VERSION
    TRIMMED_IMAGE_NAME=$(echo "$IMAGE_NAME" | tr -s '/.:' '-')
    ./grype "$IMAGE_NAME" -o "$OUTPUT_FORMAT" > "${TRIMMED_IMAGE_NAME}-vuln.${OUTPUT_FILE_FORMAT}" ${failOnSeverityFlag} ${debugFlag}
}

# Will not run if sourced from another script.
# This is done so this script may be tested.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    ScanImage
fi
