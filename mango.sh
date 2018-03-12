#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMAGE="mangoweb/mango-cli"
tab=$'\t'

function get-tags {
	curl -sS -L "https://hub.docker.com/v2/repositories/$IMAGE/tags" \
		| jq -r '.results[] | "\(.name)\t\(.last_updated)\t\(.full_size)"'
}

if [[ "$#" -eq 0 ]]; then
	echo "Usage: $0 version [args...]"
	echo "Example: mango v1.7.0 build"
	echo "Available versions: "
	(
		echo "VERSION${tab}RELEASED AT${tab}AVAILABILITY"
		while IFS=$tab read VERSION RELEASE_DATE FULL_SIZE; do
			NOTE="(local)"
			if [[ "$(docker images -q "$IMAGE:$VERSION" 2> /dev/null)" = "" ]]; then
				NOTE="$(( FULL_SIZE /1024 /1024 )) MiB"
			fi
			echo "$VERSION${tab}${RELEASE_DATE:0:10}${tab}$NOTE"
		done < <(get-tags | sort -r)
	) | column -t -s="$tab" | sed -e 's/^/    /g'
	exit
fi

docker run --rm \
  -v "$PWD":/src -w /src \
  "$IMAGE":"$1" "${@:2}"
