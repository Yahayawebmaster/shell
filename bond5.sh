#!/bin/bash
#创建一个名为bond0的链路接口
#修改IP和网卡名再运行
IP=172.16.254.2
IP2=192.168.254.2
IP3=192.168.253.2
IP4=192.168.252.2
IP5=192.168.251.2
GATE=172.16.0.1
DNS1=172.16.254.1
DNS2=223.5.5.5
ETH1=eth0
ETH2=eth1
ETH3=eth2
ETH4=eth3
MODE=5 #blance-tlb
#balance-rr(0)
#active-backup(1)
#balance-xor (2)
#broadcast (3)
#802.3ad (4)
#balance-tlb (5) 
#balance-alb (6)

modprobe bonding
cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-bond0
DEVICE=bond0
TYPE=Bond
NAME=bond0
BONDING_MASTER=yes
BOOTPROTO=static
USERCTL=no
ONBOOT=yes
#IPADDR=$IP
#PREFIX=24
#GATEWAY=$GATE
BONDING_OPTS="mode=$MODE miimon=100"
BRIDGE=br0
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH1
TYPE=Ethernet
BOOTPROTO=none
DEVICE=$ETH1
ONBOOT=yes
MASTER=bond0
SLAVE=yes
EOF
cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH2
TYPE=Ethernet
BOOTPROTO=none
DEVICE=$ETH2
ONBOOT=yes
MASTER=bond0
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH3
TYPE=Ethernet
BOOTPROTO=none
DEVICE=$ETH3
ONBOOT=yes
MASTER=bond0
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH4
TYPE=Ethernet
BOOTPROTO=none
DEVICE=$ETH4
ONBOOT=yes
MASTER=bond0
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-br0 
TYPE=Bridge
DEVICE=br0
ONBOOT=yes
IPADDR=$IP
IPADDR2=$IP2
IPADDR3=$IP3
IPADDR4=$IP4
IPADDR5=$IP5
PREFIX5=24
GATEWAY=$GATE
DNS1=$DNS1
DNS2=$DNS2
EOF

#systemctl restart network
#ping $GATE -c 1
systemctl enable NetworkManager
reboot
#check: speed 2000MB/s
# ethtool bond0
# brctl show
# ifconfig br0
