setup() {
    source ./src/scripts/scan_image.sh
}

teardown(){
    rm -f *.json *.xml *.tsv grype
}

@test '1: Scan image' {
    export IMAGE_NAME=docker-archive:./src/tests/alpine.tar
    export OUTPUT_FORMAT=json
    ScanImage
    TRIMMED_IMAGE_NAME=$(echo $IMAGE_NAME | tr -s '/.:' '-')
    output_file="${TRIMMED_IMAGE_NAME}"-vuln.json

    if [[ ! -s $output_file ]]; then
        echo "vuln file not created or empty"
        exit 2
    fi
}

@test '2: Output on cycloneDX format' {
    export IMAGE_NAME=docker-archive:./src/tests/alpine.tar
    export OUTPUT_FORMAT=cyclonedx
    ScanImage
    TRIMMED_IMAGE_NAME=$(echo $IMAGE_NAME | tr -s '/.:' '-')
    output_file="${TRIMMED_IMAGE_NAME}"-vuln.xml

    if [[ ! -s $output_file ]]; then
        echo "vuln file not created or empty"
        exit 2
    fi
}

@test '3: Output on table format' {
    export IMAGE_NAME=docker-archive:./src/tests/alpine.tar
    export OUTPUT_FORMAT=table
    ScanImage
    TRIMMED_IMAGE_NAME=$(echo $IMAGE_NAME | tr -s '/.:' '-')
    output_file="${TRIMMED_IMAGE_NAME}"-vuln.tsv

    if [[ ! -s $output_file ]]; then
        echo "vuln file not created or empty"
        exit 2
    fi
}

@test '4: Invalid output format' {
    export IMAGE_NAME=docker-archive:./src/tests/alpine.tar
    export OUTPUT_FORMAT=csv
    ScanImage | tee $result
    if [ $result != "unknown output format 'csv'" ]; then
        echo "should have erred"
        exit 2
    fi
}
