#!/usr/bin/env sh

# Check for prerequisites
command -v dpkg-deb >/dev/null 2>&1 || {
  echo >&2 "dpkg-deb could not be found, you are very likely not using Debian"
  exit 1
}
command -v apt >/dev/null 2>&1 || {
  echo >&2 "apt could not be found. Please install it: sudo apt-get install apt"
  exit 2
}
command -v sed >/dev/null 2>&1 || {
  echo >&2 "sed could not be found. Please install it: sudo apt install sed"
  exit 3
}

# Check for input
slack_package=${1}
if [ -z "${slack_package}" ]; then
  echo >&2 "Missing package location"
  echo >&2
  echo >&2 "Usage:"
  echo >&2 "  ./install.sh /path/to/slack-desktop-*.deb"
  exit 10
fi
