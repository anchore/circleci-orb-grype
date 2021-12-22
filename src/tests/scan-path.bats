setup() {
    source ./src/scripts/scan-path.sh
    export PATH_TO_SCAN=./
}

teardown() {
    rm -f *.json *.xml *.tsv grype
}

@test '1: Scan current dir' {
    export OUTPUT_FORMAT=json
    export OUTPUT_FILE="dir-vuln.json"
    ScanPath

    if [[ ! -s $OUTPUT_FILE ]]; then
        echo "vuln file not created or empty"
        exit 2
    fi
}
