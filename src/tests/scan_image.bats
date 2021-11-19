setup() {
    source ./src/scripts/scan_image.sh
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
    # clean up
    rm $output_file grype
}
