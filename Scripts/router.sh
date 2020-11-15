sudo sysctl -w net.ipv4.ip_forward=1
mv /tmp/50-router.yaml /etc/netplan/50-router.yaml
netplan apply