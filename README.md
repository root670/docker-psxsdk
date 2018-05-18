# Docker image for PS1 homebrew development using PSXSDK

Cross-compile PS1 homebrew projects using a Docker container.

## Features
* Based on small & secure Alpine Linux distribution.
* GCC and binutils versions changeable using  `--build-arg GCC_VERSION=<version>`
  and `--build-arg BINUTILS_VERSION=<version>`
* URL to PSXSDK distribution also changeable 
* Includes cdrkit for building ISO images using mkisofs.

## Quick Start

Run this command in your project's root folder to build it inside a Docker
container:

```bash
docker run -it --rm -v "$PWD:/build" root670/docker-psxsdk make
```

This will mount the current folder to `/build` in the container and then run
`make` inside `/build`.

## Continuous Integration

You can use this Docker image to build PS1 applications on CI platforms. Here's 
an example configuration for Travis CI:

```yaml
# .travis.yml
language: c

sudo: required

services:
  - docker

script: docker run -it --rm -v "$PWD:/build" root670/docker-psxsdk make test
```

