
juju deploy --to lxc:0 mysql
juju deploy --to lxc:0 keystone
juju deploy --to lxc:0 nova-cloud-controller
juju deploy --to lxc:0 glance
juju deploy --to lxc:0 rabbitmq-server
juju deploy --to lxc:0 openstack-dashboard
juju deploy --to lxc:0 cinder


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
