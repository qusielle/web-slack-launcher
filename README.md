web-slack-launcher
==================
A script to launch [Slack web application](https://app.slack.com/client) in a
new single-tab window of Firefox.

The feature of the script, comparing to having a regular browser bookmark,
is to open Slack in a one-tab popup window that imitates an experience of
having a stand-alone application.
So, for example, clicking a link on a Slack web application page results a new
tab opened in another window having Slack window untouched.

The Slack window icon is replaced with its logo.

Requirements
------------
* `wmctrl`
* [`xseticon`](https://github.com/xeyownt/xseticon)

`xseticon` must be available under the PATH.  
Tested mostly on Xubuntu 20.04 LTS with Firefox 90.


Installation
------------
* Install `wmctrl`:
  `sudo apt-get install wmctrl`
* Follow the build and installation procedure for
  [`xseticon`](https://github.com/xeyownt/xseticon/blob/8e3da2ab747d06bec3dcdcd8f97b8b8d49e70b6b/README.md#build-and-install-instructions).
  Ensure `xseticon` available to run by this command.

Usage
-----
* Run `launch_slack.sh`
* Allow Slack web application window popup

Known limitations
-----------------
It is impossible to open Slack window without having an intermediate window
asking user to allow a popup due to absence of method to set a new window
parameter to Firefox in CLI. More details are in the documentation to the
[`launch_ff`](launch_slack.sh) function.

Upstream
--------
<https://github.com/qusielle/web-slack-launcher>

License
-------
The source code is licensed under the MIT license, which you can find in the
[LICENSE](LICENSE) file.
