#!/usr/bin/env bash

# Script to launch Slack web application in a new single-tab window of Firefox.
# `wmctrl`, `xseticon` binaries are required for the run.

set -o pipefail

declare -r open_slack_page='
data:text/html, <html><body>
<script>window.open("https://app.slack.com/client/", null, "popup");</script>
<h1>Please allow popup to run Slack in a dedicated window!<h1>
</body></html>
'

declare -r slack_icon='
iVBORw0KGgoAAAANSUhEUgAAAbwAAAG8BAMAAABXng3sAAAAElBMVEUAAABPF1EyxfLgIljssiYn
tX6Z5MjLAAAAAXRSTlMAQObYZgAAB8BJREFUeNrs1cFNA0AQBEGTwVT+yfLngYQEwu71ZFDqPd3j
N+cP9viPffjZnl/t6daVARa4w2+3Mg6SZwmAddMB3XRAW0dbR1tHW0dbZ2kdq/13X7a0jvBpwtI6
Fj5NSMdjaR3l08TS8UjHQzoeS8cjHY92PEvHIx2PpeORjsfaPOnbpB3P0vGI81a+TZaOxy1e6zZZ
Oh6XeLXbZId4ervD690mO8NT3BVe8TbZEZ7k4jw3eM2nl+ftBE90cZ4LvOrTe/NeezvAk92b98mO
HZg4DMRAFG0hI9gCLLiCcqD+WzkWDjaGOMrGGvAq+h08NDbGK5ech/y8vC/O4q1d8T5NexucmvVA
icjTngP8xxGBNw5P9CEcZg9tIMTgDZ3js113RMfiac/1/dg+hNd5CE9HL56/Zkb2cXiiPfd8NiLN
k8NT9X1jmsTzUXjac+fZ7Em/CIzDE+2557MRaZ48nn++tipPz/AMYXF4ogdhlxn7fByeqnO+cTzq
+Tg80cOAkR22IaaL8qLWyeGpOusc26Sus3hzjW366zRjr7N4Uw2ev862Kk/P8wwBFW+m7+CJvmz3
ZqF+t1yYd8f5ijdR8YpXvNluIf/gi1e84r1b8Sb6Eh6KV7yAivdBUryFeSjeyjy5Fg/Fmyo5T4q3
MA/JeZKbh+Q8yc1Dcp7k5kFy85Cch+Q8SG4ekJz3x94d5aoNA1EYXsOxyQJiKQtAYQNR2QBI7H8r
7UN7rXKFj8eepON0/tf4IR8OCBKHAAjn5r3nPOcJcp5iznOeIOcp5jx1Ho7Lec4T5DzFxuAlSUCu
nTeRO4f1eCEJ6+dNJbouL8nr5U3kLgdFXmqpkZd1xKfGS2318CZy674iLzTy5g4e2a7JS63NEh4b
i5wqL6TmWnkT9VNev443N/LICE1e6knIK94K94Q53izg0ZHYgRdSVy28iQzR5KXjecunMfq80Mmb
G3ifx5jjJTlvOpCXjuctnwdp80I3bxbzSoPG54UDeak/KW8qDHqem/eyx5uFvNdxvGCN93CeKo8n
403O0+Ila7yX85znPOe18BbnOc95zhubF6zxDH+lLu84BuXl/wh0HuXZPddS5D0zb6xTSfiqOC3O
+5Xhs9TFoxOZN+hJeIM8CCDdf5rOeTg17wlrly8FDyzgvAesXVv/ixfIfjMeALsrIwpH51zFe5jj
CZ6FwnkzAFvLdvAWmRZ+Zd3umrLP0wfC23NNGRQnD6D7vZQnz+56zk/T9wTlZZ2h1bgJucLug/Py
FNtdS/07st8LmTyzK+H/VNRhYTqr9zF8VdJh4Tp9HhR1QEGHpUL3z+8hmlEs5M/MCh7Enflx5M4b
POeNnPNGznkj57yRc97IOW/knPfe+q0rvhfzpkKXu6QraJzHcZwX80YUuksDqZe3El7WcV8kFubT
562Ml3U5omv16fNWxss67iMO5tPnxTpeaXvu1sjbkNPlrVU87uefmXz69HlrgUemmByacp8+L9bx
yAg6ebwNe/DWAo++CGTyZGEHXqzjsSF88njXo3l8FJk8UdsOvFWRF+996fNiHY+P4ccmb1PnrYRH
XwRybMoyzYvmeJHwRG/QSzdvs8y7meOtjMdfBPLWk+U8PZ5s1MUcL1rjbc7bhcfffLdBebGOd1fo
hypvtca7O895znOe85znPOf9h7yTf+es5J3zFwPqeKP+3hueB2s8HMe7VvIGPVN2Al5U4A16Ev4n
e3d7mzAQBGE46YCR3YglGkB2/zXlR34Q5eO0y+5cxjBvBX50ixD47MP5eWjgKd8AG+yLmM/bJ/IQ
5SnfnUUnD3L31kcbyvK8q9zOCAwuOs1b5bbtYLB4MZ70rqQ/Lh5xnvaeMiyDxcvyQPhWIOznxKO8
RW4/5y+Xj4d5WOV242IwmmkeaqPJ4GGgS/MgtxMeGOjSPMg9x/CVsKHKw7X0uWPwgDuuzANqSxfm
5Svw+JmXzbxpmZfNvGmZl828aZmXzbxpmZfNvM9msP+Rd/wM3Wnxjht6E+N1L6Acb0dncrze+dTj
HRv6EuQd6EuR1zieirwDbUny+pZPknegK01e2/Jp8nY0pck70JQor2s6X4T3jqbyPP50XsyLlOPR
p9O8TEkefTrNy2RemLehnjDvhnrmJTLPPPOimZfIPPPMi2ZeohfhBd8ReD3pD6IgbzWvFom3xHgn
/Ssp+vJY84pReOH3Up/zX+qn5wXfCc+fTVHehp4ovPqBBWiKwgufpsGfTQqvehYK2iLxlgpvR19T
efgWfzYpvNoxS2iMxEPwmW6+jsNbIjqAP5oUXvSAupW+eBxe9DkM+l5jFm+J6AD2aJJ40aM9QdbR
eMDoc3dvJT9lc3n7aO+ObSMGohgKjjuge3H/tTk8OLAT44J9K3YwIL8UCfL5prxwf+XrvZ8QSf8V
+eGdnId3ch7eycHHZzZ7eAfnAl742eLhHZwbeNlnyx7ewZn08Xl4B4fy8e3hHZxJH59LeMl17hZe
cp2u4QXXuXt4wXW6iJdb56TrcxUvts7dxYutk3J9o1yf63ihdU66Psr1jXJ9lOvbnbzIOinXN8r1
Ua5vyr5Bd54I1zfK9VGub8q+QXeeCNc3Zd8I+wZUz4+yj7KPso+yj7LPj8TeDyPsG7LAeaV3gQDF
BgcUib/SziP/g/INx2GsD5V6XvIAAAAASUVORK5CYII=
'

# Print running web Slack window ID.
#
# Return:
#     0 if window is found, non-zero otherwise.
#
# Output:
#     Window ID in a hex format. E.g.: `0xdeadbeef`.
get_slack_window_id() {
    wmctrl -l | grep -Poe '^(.+?)(?= .+Slack .* Firefox)'
}

# Launch Firefox window with the page asking user to popup the Slack app.
#
# The feature of the script, comparing to having a regular browser bookmark,
# is to open Slack in a one-tab popup window that imitates an experience of
# having a stand-alone application. The way to set a new window parameter
# (without creating a new browser profile) is to create it via page JavaScript,
# that brings us to a need of having intermediate page, like `$open_slack_page`.
# The only purpose is to ask user to allow to open a popup window and this
# cannot be automated in modern browsers.
#
# Return:
#     0 if Firefox intermedaite window is opened, non-zero otherwise.
launch_ff() {
    echo 'Launching FF with startup page...'
    echo 'Please allow popup!'
    firefox --new-window "$open_slack_page"
}

# Override Slack Firefox window icon with the brand icon.
#
# It is impossible to set a window icon from inside Firefox itself, so use a
# magic by `xseticon` tool.
#
# Return:
#     0 if icon is set, 1 if Slack window is not found.
set_icon() {
    echo 'Setting Slack icon...'
    local -r target_window_id=$(get_slack_window_id)
    [[ -z $target_window_id ]] && return 1
    xseticon -id "$target_window_id" <(base64 -d - <<<"$slack_icon")
}

# Perform the main script scenario:
# - open Firefox window asking user to allow Slack popup
# - wait 120 seconds for Slack window
# - set Slack logo window icon
#
# Do not open a window if web Slack is already running.
#
# Return:
#     0 if scenario completed, non-zero otherwise.
main() {
    [[ -z $(get_slack_window_id) ]] && { launch_ff || return 1; }
    for _ in $(seq 120); do
        sleep 1
        set_icon && break
    done
}

main
