[![CircleCI Build Status](https://circleci.com/gh/anchore/circleci-orb-grype.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/anchore/circleci-orb-grype) 
[![CircleCI Orb Version](https://badges.circleci.com/orbs/anchore/grype.svg)](https://circleci.com/orbs/registry/orb/anchore/grype) 
[![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/anchore/circleci-orb-grype/blob/main/LICENSE)

# Grype Orb for CircleCI

All orbs are tested with .circleci/config.yaml of this repo. Finished orbs will be published to the public CircleCi orb repository under the anchore namespace.

* Orb testing will be initiated upon pushing to repo
* If orb passes linting & packing it will be published using `@dev:alpha`

After the `@dev:alpha` orb is successfully published, integration tests will be triggered. Once all tests have passed, the dev orb can be promoted to production. To View the current version of the orb, use the following command:

```
circleci orb info anchore/anchore-engine
```

Use `Makefile` for repetitive operations such as: building, validation and publishing to CircleCI. 

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/anchore/circleci-orb-grype) - The official registry page of this orb for all versions, executors, commands, and jobs described.
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.

### How to Contribute

We welcome [issues](https://github.com/anchore/circleci-orb-grype/issues) to and [pull requests](https://github.com/anchore/circleci-orb-grype/pulls) against this repository!
