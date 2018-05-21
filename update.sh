#/bin/bash
#
# Update RPM dependencies and spec file for a new release of Signal-Desktop.
#

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
spec_file="${script_dir}/SPECS/signal.spec"

set -e

get_latest_version() {
  curl --silent 'https://api.github.com/repos/signalapp/Signal-Desktop/releases/latest' | \
      grep '"tag_name":' | \
      sed -E 's/.*"([^"]+)".*/\1/' | \
      cut -d 'v' -f 2-
}

echo "Querying latest Signal version..."
latest_version=$(get_latest_version)
echo "Latest version is: $latest_version"

download_latest_version() {
  source_archive="${script_dir}/SOURCES/Signal-Desktop-${latest_version}.tar.gz"
  tarball_url=$(curl --silent 'https://api.github.com/repos/signalapp/Signal-Desktop/releases/latest' | \
      grep '"tarball_url":' | \
      sed -E 's/.*"([^"]+)".*/\1/')
  curl -L -o "$source_archive" "$tarball_url" --progress-bar
}

signal_archive="${script_dir}/SOURCES/Signal-Desktop-${latest_version}.tar.gz"

# Download the new release if we don't have it already..
if [ ! -f "$signal_archive" ]
then
    echo "Downloading latest release..."
    download_latest_version
    echo "Release downloaded."

    # Update the version string in the spec file.
    sed -i "s/%define version .*/%define version $latest_version/" "$spec_file"

    echo "Update applied."
    echo -e "You can now rebuild the rpm package with:\nmake clean; make build"
    exit 0
else
    echo "No update required."
    exit 1
fi
