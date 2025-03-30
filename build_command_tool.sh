#! /bin/bash

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

# Step1: check arch for current MacOS
if [ "$(uname -m)" = "arm64" ]; then
    # Apple Silicon（M1/M2芯片）
    ARCH="arm64-apple-macosx"
    ARCH_PREFIX="arm64"
else
    # Intel芯片
    ARCH="x86_64-apple-macosx"
    ARCH_PREFIX="x86_64"
fi

# Step2: build Swift package project
swift build

# Step3: copy binary file to Bin directory
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
