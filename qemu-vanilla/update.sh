#!/bin/bash
#
# Copyright (c) 2018 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0
#

# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

# Automation script to create specs to build kata containers kernel
set -e

source ../versions.txt
source ../scripts/pkglib.sh

SCRIPT_NAME=$0
SCRIPT_DIR=$(dirname $0)
PKG_NAME="qemu-vanilla"
VERSION=$qemu_vanilla_version

GENERATED_FILES=(qemu-vanilla.dsc qemu-vanilla.spec debian.rules _service debian.control )
STATIC_FILES=(debian.compat ../scripts/configure-hypervisor.sh qemu-vanilla-rpmlintrc)

# Parse arguments
cli "$@"

[ "$VERBOSE" == "true" ] && set -x
PROJECT_REPO=${PROJECT_REPO:-home:${OBS_PROJECT}:${OBS_SUBPROJECT}/qemu-vanilla}
RELEASE=$(get_obs_pkg_release "${PROJECT_REPO}")
((RELEASE++))
[ -n "$APIURL" ] && APIURL="-A ${APIURL}"

replace_list=(
"VERSION=$VERSION"
"RELEASE=$RELEASE"
"QEMU_VANILLA_HASH=${qemu_vanilla_hash:0:10}"
)

verify
echo "Verify succeed."
get_git_info
changelog_update $VERSION
generate_files "$SCRIPT_DIR" "${replace_list[@]}"
build_pkg "${PROJECT_REPO}"
