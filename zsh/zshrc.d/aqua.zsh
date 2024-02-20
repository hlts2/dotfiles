if ! type aqua > /dev/null 2>&1; then
    curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v${AQUA_VERSION}/aqua-installer | bash
fi
