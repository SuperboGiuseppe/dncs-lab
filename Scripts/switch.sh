export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common
mv /tmp/50-switch.yaml /etc/netplan/50-switch.yaml
netplan apply

# Startup commands for switch go here