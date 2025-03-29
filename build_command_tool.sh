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
else
    # Intel芯片
    ARCH="x86_64-apple-macosx"
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
else
    log_failure "[Error] ${SRC_FOLDER} not found!"
    exit 1
fi
