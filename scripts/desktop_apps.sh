#!?/bin/bash

find /usr/share/applications ~/.local/share/applications -name '*.desktop' -print0 | xargs -0 grep -i -l "Terminal=False"
