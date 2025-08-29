#!/usr/bin/env bash

## Usage:
# $ ./build_command_tool.sh
# $ ./build_command_tool.sh --arch arm64
# $ ./build_command_tool.sh --arch x86_64

log_success() {
  local GREEN="\033[0;32m"
  local NORMAL="\033[0m"
  printf "${GREEN}%s${NORMAL}\n" "$@" >&2
}

log_failure() {
  local RED="\033[0;31m"
  local NORMAL="\033[0m"
  printf "${RED}%s${NORMAL}\n" "$@" >&2
}

# Step0: parse command line arguments
ARG_ARCH=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --arch)
      if [[ "$2" == "arm64" || "$2" == "x86_64" ]]; then
        ARG_ARCH="$2"
        shift 2
      else
        log_failure "Invalid architecture: $2. Use --arch arm64 or --arch x86_64"
        exit 1
      fi
      ;;
    *)
      log_failure "Unknown option: $1. Use --arch arm64 or --arch x86_64"
      exit 1
      ;;
  esac
done

# Step2: if not specified, use uname -m to detect
if [[ -z "$ARCH" ]]; then
    ARG_ARCH="$(uname -m)"
fi

# Step3: choose expected arch for build
if [ "$ARG_ARCH" = "arm64" ]; then
    # Apple Silicon（M1/M2芯片）
    ARCH="arm64-apple-macosx"
    ARCH_PREFIX="arm64"
else
    # Intel芯片
    ARCH="x86_64-apple-macosx"
    ARCH_PREFIX="x86_64"
fi

# Step4: build Swift package project
swift build

# Step5: copy binary file to Bin directory
FILE_NAME="VersionIcon"
SRC_FOLDER=".build/${ARCH}/debug"
DEST_FOLDER="Bin/${ARCH}"
if [ -d "${SRC_FOLDER}" ]; then
    mkdir -p "${DEST_FOLDER}"
    cp -rf "${SRC_FOLDER}/${FILE_NAME}" "${DEST_FOLDER}"
    log_success "Succeed to generate command tool ${FILE_NAME} for ${ARCH} in ${DEST_FOLDER}. Enjoy yourself!🍺🍺🍺"

    # Step4 (Optional): Copy binary to ExampleProject for testing
    BIN_FOLDER="./ExampleProject/run_script_version_icon/bin/${ARCH_PREFIX}"
    if [ -d "${BIN_FOLDER}" ]; then
        cp -rf "${DEST_FOLDER}/${FILE_NAME}" "${BIN_FOLDER}"
    else
        log_failure "[Warn] ${BIN_FOLDER} not found!"
        exit 1
    fi
else
    log_failure "[Error] ${SRC_FOLDER} not found!"
    exit 1
fi
