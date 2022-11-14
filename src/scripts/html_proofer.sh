#!/usr/bin/env bash

PATH_TO_FILES=$(eval "echo $ORB_EVAL_PATH")
ALT_IGNORE=$(eval "echo $ORB_EVAL_ALT_IGNORE")
DIRECTORY_INDEX_FILE=$(eval "echo $ORB_EVAL_DIRECTORY_INDEX_FILE")
CHECKS_TO_IGNORE=$(eval "echo $ORB_EVAL_CHECKS_TO_IGNORE")
EXTENSION=$(eval "echo $ORB_EVAL_EXTENSION")
FILE_IGNORE=$(eval "echo $ORB_EVAL_FILE_IGNORE")
HTTPS_STATUS=$(eval "echo $ORB_EVAL_HTTPS_STATUS")
INTERNAL_DOMAINS=$(eval "echo $ORB_EVAL_INTERNAL_DOMAINS")
STORAGE_DIR=$(eval "echo $ORB_EVAL_STORAGE_DIR")
URL_IGNORE=$(eval "echo $ORB_EVAL_URL_IGNORE")
URL_SWAP=$(eval "echo $ORB_EVAL_URL_SWAP")

# # flattened key value list of boolean parameters and their corresponding flags
check_flags=(ORB_VAL_MISSING_HREF --allow-missing-href
    ORB_VAL_HASH_HREF --allow-hash-href
    ORB_VAL_AS_LINKS --as-links
    ORB_VAL_ASSUME_EXTENSION --assume-extension
    ORB_VAL_EXTERNAL_HASH --check-external-hash
    ORB_VAL_CHECK_FAVICON --check-favicon
    ORB_VAL_CHECK_HTML --check-html
    ORB_VAL_CHECK_IMG_HTTP --check-img-http
    ORB_VAL_CHECK_OPENGRAPH --check-opengraph
    ORB_VAL_CHECK_SRI --check-sri
    ORB_VAL_DISABLE_EXTERNAL --disable-external
    ORB_VAL_EMPTY_ALT_IGNORE --empty-alt-ignore
    ORB_VAL_ENFORCE_HTTPS --enforce-https
    ORB_VAL_EXTERNAL_ONLY --external_only
    ORB_VAL_INVALID_TAGS --report-invalid-tags
    ORB_VAL_MISSING_NAMES --report-missing-names
    ORB_VAL_SCRIPT_EMBEDS --report-script-embeds
    ORB_VAL_MISSING_DOCTYPE --rareport-missing-doctype
    ORB_VAL_EOF_TAGS --report-eof-tags
    ORB_VAL_MISMATCHED_TAGS --report-mismatched-tags
    ORB_VAL_ONLY_FOURXX --only-4xx)

flags=()

# evaluate boolean parameters and assign flag if set 
for (( i = 0; i < ${#check_flags[@]} / 2; i++ )); do
    real_index=$((i * 2))
    flag_enabled=$(eval "echo \$${check_flags[$real_index]}")

    if [ "$flag_enabled" = 1 ]; then
        arg_index=$((real_index + 1))
        flags+=("${check_flags[$arg_index]}")
    fi
done

echo "${flags[@]}"

if [ "$ORB_VAL_ERRORT_SORT" = 1 ]; then
    flags+=(--error-sort "$ORB_VAL_ERRORT_SORT")
fi

set -x
htmlproofer "$PATH_TO_FILES" \
    --alt-ignore "$ALT_IGNORE" \
    --checks-to-ignore "$CHECKS_TO_IGNORE" \
    --directory-index-file "$DIRECTORY_INDEX_FILE" \
    --extension "$EXTENSION" \
    --file-ignore "$FILE_IGNORE" \
    --http-status-ignore "$HTTPS_STATUS" \
    --internal-domains "$INTERNAL_DOMAINS" \
    --log-level "$ORB_VAL_LOG_LEVEL" \
    --storage-dir "$STORAGE_DIR" \
    --timeframe "$ORB_VAL_TIMEFRAME" \
    --typhoeus-config "$ORB_VAL_TYPHOEUS_CFG" \
    --url-ignore "$URL_IGNORE" \
    --url-swap "$URL_SWAP" \
    "${flags[@]}"
set -x
