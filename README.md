# Slack installer for Debian 11

The DEB package provided by Slack on [their download page](https://slack.com/downloads/linux)
is not compatible with Debian 11. 

This script aims at letting you install that package safely.

This script does not aim at letting you update the package easily: for every update, you have to download the DEB
archive and run that script.

## Usage

### 1. Download the DEB package from the Slack download page.

The package is available on that page: https://slack.com/downloads/linux

### 2. Run the installation helper on that package

Run the following script passing the package you downloaded: 

```shell
./install.sh /path/to/slack-desktop-*.deb
```
