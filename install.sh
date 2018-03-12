#!/usr/bin/env bash
set -euo pipefail

TARGET="/usr/local/bin/mango"

if [[ -e "$TARGET" ]]; then
	echo "WARNING: $TARGET already exists"
	echo "Installer will continue in 5 seconds..."
	sleep 5
fi

if which -s docker; then
	echo "docker found"
else
	echo "docker not found"
	echo "see https://docs.docker.com/docker-for-mac/"
	exit 1
fi

if which -s brew; then
	echo "brew found"
else
	echo "brew not found, installing"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if which -s jq; then
	echo "jq found"
else
	echo "jq not found, installing"
	brew install jq
fi

if which -s curl; then
	echo "curl found"
else
	echo "curl not found, installing"
	brew install curl
fi

curl -sS -L "https://s3-eu-west-1.amazonaws.com/build.mangoweb.org/mango-ca8d860d50994f17186e/mango.sh" \
	> "$TARGET"

chmod a+x "$TARGET"

echo "Installed into $TARGET, which should be available as 'mango'"
echo "---------"
echo "Try running this command:"
echo "  mango"
