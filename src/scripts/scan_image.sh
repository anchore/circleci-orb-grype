#!/usr/bin/env bash

ScanImage() {
    failOnSeverityFlag=""
    if [ ! -z "$FAIL_ON" -a "$FAIL_ON" != " " ]; then
        failOnSeverityFlag="-f ${FAIL_ON}"
    fi

    curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b . latest
    TRIMMED_IMAGE_NAME=$(echo $IMAGE_NAME | tr -s '/.:' '-')
    ./grype $IMAGE_NAME -o $OUTPUT_FORMAT > "${TRIMMED_IMAGE_NAME}-vuln.json" ${failOnSeverityFlag:+$failOnSeverityFlag}
}

# Will not run if sourced from another script.
# This is done so this script may be tested.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    ScanImage
fi
