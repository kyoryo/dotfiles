# script to Tiny-launch polybar

#!/usr/bin/env bash

echo "---" | tee -a /tmp/polybar2.log
polybar tray --config=$HOME/.config/polybar/blocks/config.ini >> /tmp/polybar2.log 2>&1

~                                                                                                    
~   