#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"


bash "${SCRIPT_DIR}"/installation/main.sh
# Temporarily turning off the `-e` option
set +e
snyk_exist_code=$(snyk test ...)
if [ "$snyk_exist_code" = 3 ]; then
  echo "No supported projects detected"
  exit 0
else
  snyk test "$@"
fi
set -e
exit "$snyk_exist_code"