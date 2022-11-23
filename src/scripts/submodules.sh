#!/usr/bin/env bash

if [ -f ".gitmodules" ]; then
    git submodule sync
    git submodule update --init --recursive
fi