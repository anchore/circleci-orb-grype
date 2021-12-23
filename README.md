[![CircleCI Build Status](https://circleci.com/gh/anchore/circleci-orb-grype.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/anchore/circleci-orb-grype) 
[![CircleCI Orb Version](https://badges.circleci.com/orbs/anchore/grype.svg)](https://circleci.com/orbs/registry/orb/anchore/grype) 
[![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/anchore/circleci-orb-grype/blob/main/LICENSE)

# Grype Orb for CircleCI

This repo is the source of the Grype CircleCI Orb, which uses [Grype](https://github.com/anchore/grype) to scan vulnerabilities in container images. This orb has one command, it scans a given image from a registry, like docker.io. 

To use this orb in your repo add the following to the list of jobs in your `.circleci/config.yml` (assuming you already configured circleCI in your repo, if not please check [Getting Started with CircleCI](https://circleci.com/docs/2.0/getting-started/)):

``` yaml
orbs:
  grype: anchore/grype@<version>


workflows:
  integration-test_deploy:
    jobs:
      - grype/list-image-vulns:
          image-name: ubuntu:20.04 # grype will pull this image from docker.io, by default, check the scan-image command for more options 
      - grype/list-dir-vulns:
          path-to-scan: ./
          ```

Check [Scan Image](src/commands/scan_image.yml) command for more options, such as: fail testing if an image has a vulnerability as severe or equal to `high`.

## Jobs
### grype/list-image-vulns
List vulnerabilities for a given container image.

| Parameter           | Description                                                                                                                      | Default              |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------|----------------------|
| image-name          | A container image to scan. (e.g. alpine:latest)                                                                                  |                      |
| output-format       | Report output formatter. Supported formats are: json, table, cyclonedx, template                                                 | table                |
| output-file         | File name where the list of vulnerabilities are saved.                                                                           | ./grype-vulns.output |
| fail-on-severity    | Fail scanning if a vulnerability is found with a severity >= the given severity. One of: negligible, low, medium, high, critical |                      |
| enable-verbose-logs | Flag to enable verbose logs for grype.                                                                                           | true                 |
| grype-version       | Version of grype used for orb                                                                                                    | v0.26.1              |

### grype/list-dir-vulns
List vulnerabilities for a local directory path.

| Parameter           | Description                                                                                                                      | Default              |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------|----------------------|
| path-to-scan        | Path to scan (e.g. "/home/user/project/abc" for absolute path, or "./abc" if the execution starts from "/home/user/project/")    |                      |
| output-format       | Report output formatter. Supported formats are: json, table, cyclonedx, template                                                 | table                |
| output-file`        | File name where the list of vulnerabilities are saved.                                                                           | ./grype-vulns.output |
| fail-on-severity    | Fail scanning if a vulnerability is found with a severity >= the given severity. One of: negligible, low, medium, high, critical |                      |
| enable-verbose-logs | Flag to enable verbose logs for grype.                                                                                           | true                 |
| grype-version       | Version of grype used for orb                                                                                                    | v0.26.1              |

## Commands
### grype/scan-image
Scan a Docker image with grype.

| Parameter           | Description                                                                                                                      | Default              |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------|----------------------|
| image-name          | A container image to scan. (e.g. alpine:latest)                                                                                  |                      |
| output-format       | Report output formatter. Supported formats are: json, table, cyclonedx, template                                                 | table                |
| output-file         | File name where the list of vulnerabilities are saved.                                                                           | ./grype-vulns.output |
| fail-on-severity    | Fail scanning if a vulnerability is found with a severity >= the given severity. One of: negligible, low, medium, high, critical |                      |
| enable-verbose-logs | Flag to enable verbose logs for grype.                                                                                           | true                 |
| grype-version       | Version of grype used for orb                                                                                                    | v0.26.1              |
| registry-address    | Name of private registry (e.g. docker.io, localhost:5000)                                                                        |                      |
| registry-user       | Username for private registry                                                                                                    |                      |
| registry-pass       | Password for private registry                                                                                                    |                      |
| registry-auth-token | Auth token for private registry                                                                                                  |                      |

### grype/scan-path
Scan a given path with grype.

| Parameter           | Description                                                                                                                      | Default              |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------|----------------------|
| path-to-scan        | Path to scan (e.g. "/home/user/project/abc" for absolute path, or "./abc" if the execution starts from "/home/user/project/")    |                      |
| output-format       | Report output formatter. Supported formats are: json, table, cyclonedx, template                                                 | table                |
| output-file         | File name where the list of vulnerabilities are saved.                                                                           | ./grype-vulns.output |
| fail-on-severity    | Fail scanning if a vulnerability is found with a severity >= the given severity. One of: negligible, low, medium, high, critical |                      |
| enable-verbose-logs | Flag to enable verbose logs for grype.                                                                                           | true                 |
| grype-version       | Version of grype used for orb                                                                                                    | v0.26.1              |

## Development
All orbs are tested with .circleci/config.yaml of this repo. Finished orbs will be published to the public CircleCi orb repository under the anchore namespace.

* Orb testing will be initiated upon pushing to repo
* If orb passes linting & packing it will be published using `@dev:alpha`

After the `@dev:alpha` orb is successfully published, integration tests will be triggered. Once all tests have passed, the dev orb can be promoted to production. To View the current version of the orb, use the following command:

```
circleci orb info anchore/grype
```

Use `Makefile` for repetitive operations such as: building, validation and publishing to CircleCI. 

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/anchore/circleci-orb-grype) - The official registry page of this orb for all versions, executors, commands, and jobs described.
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.

### How to Contribute

We welcome [issues](https://github.com/anchore/circleci-orb-grype/issues) to and [pull requests](https://github.com/anchore/circleci-orb-grype/pulls) against this repository!
