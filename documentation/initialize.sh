#!/usr/bin/env bash

[[ "$(command -v pre-commit)" != "" ]] && pre-commit install
[[ "$(command -v pre-commit)" != "" ]] && pre-commit install-hooks
