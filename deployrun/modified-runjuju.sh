

juju deploy  mysql --to 1
juju deploy --config openstack-config.yaml  keystone --to 1
juju deploy --config openstack-config.yaml  nova-cloud-controller --to 1
juju deploy glance --to 1
juju deploy rabbitmq-server --to 1
juju deploy  openstack-dashboard --to 1
juju deploy  --config openstack-config.yaml cinder --to 1
juju deploy --config openstack-config.yaml neutron-api --to 1
juju deploy  neutron-openvswitch 
juju deploy  nova-compute --to 2
juju deploy --config openstack-config.yaml neutron-gateway --to 1
juju deploy ceilometer --to 1
juju deploy  ceilometer-agent 
juju deploy   heat --to 1
juju deploy  nova-cell --to 1

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
#juju add-relation neutron-gateway mysql
#juju add-relation neutron-gateway rabbitmq-server
#juju add-relation neutron-gateway nova-cloud-controller
juju add-relation neutron-api neutron-gateway
juju add-relation neutron-api neutron-openvswitch
juju add-relation neutron-api nova-cloud-controller
juju add-relation neutron-openvswitch rabbitmq-server
juju add-relation neutron-openvswitch nova-compute


juju add-relation neutron-gateway mysql
#juju add-relation neutron-gateway rabbitmq-server
juju add-relation neutron-gateway nova-cloud-controller
juju add-relation neutron-gateway:amqp rabbitmq-server:amqp
juju add-relation neutron-gateway:amqp-nova rabbitmq-server:amqp

