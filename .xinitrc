# xdg-desktop-portal-gtk service doesn't read DISPLAY variable value
# So firefox file browser doesn't work, this sets it by hand.
systemctl --user import-environment DISPLAY XAUTHORITY

# Run qtile 
qtile start
