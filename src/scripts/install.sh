#!/usr/bin/env bash
ORB_EVAL_INSTALL_LOCATION=$(eval echo "${ORB_EVAL_INSTALL_LOCATION}")

case $OSD_FAMILY in
    linux)
    OS=Linux-64bit
    PKG_EXT=tar.gz
    ;;
    darwin)
    OS=darwin-universal
    PKG_EXT=tar.gz
    ;;
    *)
    echo "Unsupported operating system."
    exit 1
    ;;
esac

# If we're in Alpine, install additional compatibility packages.
if [[ $OSD_ID == "alpine" ]]; then
    apk add build-base curl libcurl libc6-compat libxml2-dev libxslt-dev
fi

if [ "${ORB_VAL_EXTENDED}" = 1 ]; then
    HUGO_EXTENDED="_extended"
else
    HUGO_EXTENDED=""
fi

HUGO_URL=https://github.com/gohugoio/hugo/releases/download/v${ORB_VAL_VERSION}/hugo${HUGO_EXTENDED}_${ORB_VAL_VERSION}_${OS}.${PKG_EXT}
curl --fail -sSL "$HUGO_URL" -o hugo-archive 2>/dev/null
# If the download fails...

if $SUDO tar -xzf hugo-archive -C "${ORB_EVAL_INSTALL_LOCATION}" hugo 2>/dev/null; then
    echo "Hugo succesfully installed."
else
    if [[ ! "${ORB_VAL_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]]; then
    echo "Failed to install. The version number ${ORB_VAL_VERSION} is not a full valid SemVer version."
    else
    echo "Please choose a valid version from the Hugo tags page, without the leading 'v': https://github.com/gohugoio/hugo/tags"
    echo "The download URL that failed was: ${HUGO_URL}"
    fi

    exit 1
fi
