#!/bin/bash
set -e

# allow the container to be started with `--user`
if [[ "$*" == node*index* ]] && [ "$(id -u)" = '0' ]; then
	chown -R node "$GHOST_CONTENT"
	exec su-exec node "$BASH_SOURCE" "$@"
fi

if [[ "$*" == node*index* ]]; then
	baseDir="$GHOST_SOURCE/content"
	for dir in "$baseDir"/*/ "$baseDir"/themes/*/; do
		targetDir="$GHOST_CONTENT/${dir#$baseDir/}"
		mkdir -p "$targetDir"
		if [ -z "$(ls -A "$targetDir")" ]; then
			tar -c --one-file-system -C "$dir" . | tar xC "$targetDir"
		fi
	done

	if [ ! -e "$GHOST_CONTENT/config.js" ]; then
          echo "This image requires $GHOST_CONTENT/config.js to be provided"
          echo "Ensure it binds to 0.0.0.0"
          echo "And the path to the DB is underneath $GHOST_CONTENT"
          exit 1
	fi
fi

exec "$@"
