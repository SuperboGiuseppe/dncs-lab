export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common


# Startup commands for switch go here

#Moving and applying netplan configuration in the netplan directory configuration. This cannot be achieved by inline command as vagrant user do not have the rights to
#directly perform a "mv" action in a directory only
mv /tmp/50-switch.yaml /etc/netplan/50-switch.yaml
netplan apply

#Switching configuration - The solution is based on two bridges (One for each interface) connected with patches

#Creating two bridges
ovs-vsctl add-br host-a-br
ovs-vsctl add-br host-b-br

#Adding the corresponding interface on each bridge
ovs-vsctl add-port host-a-br enp0s9
ovs-vsctl add-port host-a-br enp0s10

#Enable the connection between the bridges by using patch interfaces
ovs-vsctl add-port host-a-br patch1
ovs-vsctl set interface patch1 type=patch
ovs-vsctl set interface patch1 options:peer=patch2

ovs-vsctl add-port host-a-br patch2
ovs-vsctl set interface patch2 type=patch
ovs-vsctl set interface patch2 options:peer=patch1

#Enable the bridges interfaces
ifconfig host-a-br up
ifconfig host-b-br up

#As stated in the Openvswitch documentation it is necessary to apply the ip configuration of the corresponding interface to the bridge interfaces. First of all it is necessary
#to remove the configuration from the main interfaces.
ifconfig enp0s9 0
ifconfig enp0s10 0

#Then apply the same configuration on the bridges interfaces (TO BE PARAMETERIZED)
ifconfig host-a-br 172.16.0.126/25
ifconfig host-b-br 172.16.1.254/24