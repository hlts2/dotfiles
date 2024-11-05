if ! type aqua > /dev/null 2>&1; then
	if type go > /dev/null 2>&1; then
		go install github.com/aquaproj/aqua/v2/cmd/aqua@latest
	fi
    # curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v${AQUA_VERSION}/aqua-installer | bash
fi
