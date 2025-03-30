#!/usr/bin/env bash
set -e
set -x

# Usage: 
# bash "${PROJECT_DIR}/run_script_version_icon/main.sh"

# Step1: check arch for current MacOS
if [ "$(uname -m)" = "arm64" ]; then
    # Apple Silicon（M1/M2芯片）
    COMMAND="${PROJECT_DIR}/run_script_version_icon/bin/arm64/VersionIcon"
else
    # Intel芯片
    COMMAND="${PROJECT_DIR}/run_script_version_icon/bin/x86_64/VersionIcon"
fi

# Step2: check if the script is running in Xcode
if [ "${CONFIGURATION}" = "Release" ]; then
    "${COMMAND}" --resources "${PROJECT_DIR}/run_script_version_icon/resources" --original
else
    #"${COMMAND}" --ribbon Blue-TopRight.png --title Devel-TopRight.png --resources "Pods/VersionIcon/Bin" --strokeWidth 0.07
    "${COMMAND}" --resources "${PROJECT_DIR}/run_script_version_icon/resources" --ribbon "Green-TopRight.png" --title "Debug-TopRight.png"
fi
