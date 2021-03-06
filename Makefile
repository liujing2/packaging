#
# Copyright (c) 2018 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0
#
#

MK_DIR :=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.PHONY: test test-release-tools

test: test-release-tools test-packaging-tools

test-release-tools:
	@$(MK_DIR)/release/tag_repos_test.sh

test-packaging-tools:
	@$(MK_DIR)/build_from_docker.sh
