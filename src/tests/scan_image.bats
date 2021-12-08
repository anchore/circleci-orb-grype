setup() {
    source ./src/scripts/scan_image.sh
    export IMAGE_NAME=alpine:latest
    export GRYPE_VERSION="v0.26.1"
    export ENABLE_DEBUG_LOGS=true
}

teardown() {
    rm -f *.json *.xml *.tsv grype
}

@test '1: Scan image' {
    export OUTPUT_FORMAT=json
    export OUTPUT_FILE="alpine-vuln.json"
    ScanImage

    if [[ ! -s $OUTPUT_FILE ]]; then
        echo "vuln file not created or empty"
        exit 2
    fi
}

@test '2: Output on cycloneDX format' {
    export OUTPUT_FORMAT=cyclonedx
    export OUTPUT_FILE=alpine-vuln.xml
    ScanImage

    if [[ ! -s $OUTPUT_FILE ]]; then
        echo "vuln file not created or empty"
        exit 2
    fi
}

@test '3: Output on table format' {
    export OUTPUT_FORMAT=table
    export OUTPUT_FILE=alpine-vuln.tsv
    ScanImage

    if [[ ! -s $OUTPUT_FILE ]]; then
        echo "vuln file not created or empty"
        exit 2
    fi
}

@test '4: Invalid output format' {
    export OUTPUT_FORMAT=csv
    ScanImage | tee $result
    if [ $result != "unknown output format 'csv'" ]; then
        echo "should have erred"
        exit 2
    fi
}
