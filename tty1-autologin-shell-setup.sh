#!/bin/bash
# Force console boot (no GUI ever)
systemctl set-default multi-user.target

# Kill getty completely on tty1 + start root shell directly
mkdir -p /etc/systemd/system/getty@tty1.service.d
cat > /etc/systemd/system/getty@tty1.service.d/nologin.conf <<EOF
[Service]
ExecStart=
ExecStart=-/bin/bash
StandardInput=tty
StandardOutput=tty
EOF

# Remove root password
passwd -d root

# the above code is completely written by an LLM
