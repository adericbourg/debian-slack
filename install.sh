#!/usr/bin/env bash

FIXED_PACKAGE_NAME="slack-desktop-deb11.deb"

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

# Setup work directory
work_dir=$(mktemp -d --suffix="slack-installer")

function cleanup {
  rm -rf "${work_dir}"
}

trap cleanup EXIT

cd "${work_dir}" || {
  echo >&2 "WTF?!"
  exit 42
}

dpkg-deb -x "${slack_package}" unpack
dpkg-deb --control "${slack_package}"
mv DEBIAN unpack

sed -i 's/libappindicator3-1/libayatana-appindicator3-1/g' ./unpack/DEBIAN/control

dpkg -b unpack "${FIXED_PACKAGE_NAME}"

read -p "Install package (this will ask for your sudo password)? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo apt install "./${FIXED_PACKAGE_NAME}"
fi

package_directory=$(dirname "${slack_package}")
mv "./${FIXED_PACKAGE_NAME}" "${package_directory}"

cd - >/dev/null 2>&1 || {
  echo >&2 "WTF back?!"
  exit 42
}

echo "Fixed package successfully built: ${package_directory}/${FIXED_PACKAGE_NAME}"
