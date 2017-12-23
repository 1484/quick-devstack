#!/bin/bash

source $HOME/devstack/openrc admin admin

function get_uuid () { cat - | grep " id " | awk '{print $4}'; }

nova flavor-create --ephemeral 10 standard.xsmall 100 1024 10 1
nova flavor-create --ephemeral 10 standard.small 101 2048 10 2
nova flavor-create --ephemeral 50 standard.medium 102 4096 50 2

openstack project create SNSApp
SNSAPP_TENANT_ID=`openstack project show SNSApp | get_uuid`

openstack user create snsapp-infra-user --project SNSApp --password passw0rd
openstack user create snsapp-infra-admin --project SNSApp --password passw0rd
openstack role add --project SNSApp --user snsapp-infra-admin admin
openstack role add --project SNSApp --user snsapp-infra-user Member

nova quota-update --instances 20 --cores 40 --ram 102400 $SNSAPP_TENANT_ID

sudo ip addr del 172.24.4.1/24 dev br-ex
neutron router-gateway-clear router1
neutron net-delete Ext-Net

neutron net-create Ext-Net --router:external=True
neutron subnet-create --name Ext-Subnet --allocation-pool start=192.168.100.129,end=192.168.100.179 --gateway 192.168.100.1 --disable-dhcp Ext-Net 192.168.100.0/24
neutron router-gateway-set router1 Ext-Net

sudo ovs-vsctl add-port br-ex eth1  ### NIC名を固定化させるscript書いて事前に固定化させる必要がある？

nova aggregate-create ag1 az1
id=$(nova aggregate-list | grep " ag1 " | cut -d"|" -f2)
nova aggregate-add-host $id stack02

nova aggregate-create ag2 az2
id=$(nova aggregate-list | grep " ag2 " | cut -d"|" -f2)
nova aggregate-add-host $id stack03

nova aggregate-list
nova availability-zone-list
cinder availability-zone-list

env | grep ^OS_ | sed -e 's/^OS_/export OS_/' > $HOME/openrc-keystone-admin
