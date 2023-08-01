if ! type aqua > /dev/null 2>&1; then
    if type go > /dev/null 2>&1; then
        go install github.com/aquaproj/aqua/v2/cmd/aqua@v2.11.0-4
    fi
fi

# aqua install -a
