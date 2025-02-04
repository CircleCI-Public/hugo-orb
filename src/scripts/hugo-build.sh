#!/usr/bin/env bash
ORB_EVAL_SOURCE=$(eval echo "${ORB_EVAL_SOURCE}")
ORB_EVAL_DESTINATION=$(eval echo "${ORB_EVAL_DESTINATION}")
ORB_EVAL_HUGO_ENV=$(eval echo "${ORB_EVAL_HUGO_ENV}")
ORB_EVAL_HUGO_EXTRA_FLAGS=$(eval echo "${ORB_EVAL_HUGO_EXTRA_FLAGS}")

export HUGO_ENV="${ORB_EVAL_HUGO_ENV}"

hugo build -s "${ORB_EVAL_SOURCE}" -d "${ORB_EVAL_DESTINATION}" "${ORB_EVAL_HUGO_EXTRA_FLAGS}"
