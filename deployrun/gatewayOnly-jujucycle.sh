

juju deploy  mysql
juju deploy --config openstack-config.yaml  keystone
juju deploy --config openstack-config.yaml  nova-cloud-controller
juju deploy glance
juju deploy rabbitmq-server
juju deploy  openstack-dashboard
juju deploy  --config openstack-config.yaml cinder
#juju deploy --config openstack-config.yaml neutron-api
#juju deploy  neutron-openvswitch
juju deploy ceilometer
juju deploy  ceilometer-agent
juju deploy   heat
juju deploy  nova-cell
juju deploy mongodb
juju set-constraints "cpu-cores=3 mem=8096M root-disk=46384M"
juju deploy  --config openstack-config.yaml nova-compute
juju deploy --config openstack-config.yaml neutron-gateway
juju set-constraints "cpu-cores=1 mem=4096M root-disk=16384M"

juju add-relation mysql keystone
juju add-relation nova-cloud-controller mysql
juju add-relation nova-cloud-controller rabbitmq-server
juju add-relation nova-cloud-controller glance
juju add-relation nova-cloud-controller keystone
juju add-relation nova-compute nova-cloud-controller
juju add-relation nova-compute mysql
juju add-relation nova-compute rabbitmq-server:amqp
juju add-relation nova-compute glance
juju add-relation glance mysql
juju add-relation glance keystone
juju add-relation glance cinder
juju add-relation mysql cinder
juju add-relation cinder rabbitmq-server
juju add-relation cinder nova-cloud-controller
juju add-relation cinder keystone
juju add-relation openstack-dashboard keystone

juju add-relation heat mysql
juju add-relation heat rabbitmq-server
juju add-relation heat keystone

## enable ceilometer endpoint
juju add-relation ceilometer mongodb
juju add-relation ceilometer:identity-notifications keystone:identity-notifications
juju add-relation ceilometer:identity-service keystone:identity-service
juju add-relation ceilometer rabbitmq-server
juju add-relation ceilometer-agent nova-compute
juju add-relation ceilometer:ceilometer-service ceilometer-agent:ceilometer-service
juju expose mongodb
juju expose ceilometer
juju expose ceilometer-agent

#juju add-relation neutron-api mysql
#juju add-relation neutron-api keystone
#juju add-relation neutron-api rabbitmq-server
#juju add-relation neutron-gateway mysql
#juju add-relation neutron-gateway rabbitmq-server
#juju add-relation neutron-gateway nova-cloud-controller
#juju add-relation neutron-api neutron-gateway
#juju add-relation neutron-api neutron-openvswitch
#juju add-relation neutron-api nova-cloud-controller
#juju add-relation neutron-openvswitch rabbitmq-server
#juju add-relation neutron-openvswitch nova-compute


juju add-relation neutron-gateway mysql
#juju add-relation neutron-gateway rabbitmq-server
juju add-relation neutron-gateway nova-cloud-controller
juju add-relation neutron-gateway:amqp rabbitmq-server:amqp
juju add-relation neutron-gateway:amqp-nova rabbitmq-server:amqp

## additional virtual nic required for neutron-gateway

sudo virsh net-list
sudo virsh net-define custom-virtual-nic3.xml
sudo virsh net-define custom-virtual-nic4.xml
sudo virsh net-autostart  bridge70
sudo virsh net-autostart  bridge80
sudo virsh net-start bridge70
sudo virsh net-start bridge80
neutronGatewayMachine=`juju stat neutron-gateway |  grep instance | awk '{print $2}'`

sudo virsh attach-interface --domain $neutronGatewayMachine  --type network  --source bridge70 --model virtio --config --live
sudo virsh attach-interface --domain $neutronGatewayMachine  --type network  --source bridge80 --model virtio --config --live

