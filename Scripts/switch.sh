export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common


# Startup commands for switch go here

#Creating a bridge interface
ovs-vsctl add-br switch

#Creating interfaces for each connect host and the router.
ovs-vsctl add-port switch enp0s8
ovs-vsctl add-port switch enp0s9 tag="2"
ovs-vsctl add-port switch enp0s10 tag="3"

#Enabling the interfaces
ip link set dev enp0s8 up
ip link set dev enp0s9 up
ip link set dev enp0s10 up

