#命令行启动vmware workstation vm:
vmrun -T ws start /mnt/vms/docker1b/docker1b.vmx nogui

virsh start kvm01


#停止；suspend;resume
vmrun -T ws stop /mnt/vms/docker1b/docker1b.vmx nogui

#clone含两块硬盘的KVM虚机：
virt-clone -o node1 -n node2 -f /mnt/kvm/centos7-node2.img /mnt/kvm/node2-osd.img

#随开机启动
virsh autostart node1

#SNAT
iptables -t nat -A POSTROUTING -s 192.168.41.0/24 -d !192.168.41.0/24 -o wlan0 -j MASQUERADE