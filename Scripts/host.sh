export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
mv /tmp/50-host.yaml /etc/netplan/50-host.yaml
netplan apply
# Return to old network interface naming convetion eth0.
#sed 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0/"' /etc/default/grub