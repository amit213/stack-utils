

juju deploy  mysql
juju deploy --config openstack-config.yaml  keystone
juju deploy --config openstack-config.yaml  nova-cloud-controller
juju deploy glance
juju deploy rabbitmq-server
juju deploy  openstack-dashboard
juju deploy  --config openstack-config.yaml cinder
juju deploy --config openstack-config.yaml neutron-api
juju deploy  neutron-openvswitch
juju deploy  nova-compute
juju deploy --config openstack-config.yaml neutron-gateway
juju deploy ceilometer
juju deploy  ceilometer-agent
juju deploy   heat
juju deploy  nova-cell

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

juju add-relation neutron-api mysql
juju add-relation neutron-api keystone
juju add-relation neutron-api rabbitmq-server
juju add-relation neutron-gateway mysql
juju add-relation neutron-gateway rabbitmq-server
juju add-relation neutron-gateway nova-cloud-controller
juju add-relation neutron-api neutron-gateway
juju add-relation neutron-api neutron-openvswitch
juju add-relation neutron-api nova-cloud-controller
juju add-relation neutron-openvswitch rabbitmq-server
juju add-relation neutron-openvswitch nova-compute

