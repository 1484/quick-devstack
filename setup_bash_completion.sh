#!/bin/bash -x
sudo wget -q -O /etc/bash_completion.d/nova https://raw.githubusercontent.com/openstack/python-novaclient/master/tools/nova.bash_completion
sudo wget -q -O /etc/bash_completion.d/neutron https://raw.githubusercontent.com/openstack/python-neutronclient/master/tools/neutron.bash_completion
sudo wget -q -O /etc/bash_completion.d/cinder https://raw.githubusercontent.com/openstack/python-cinderclient/master/tools/cinder.bash_completion
sudo wget -q -O /etc/bash_completion.d/keystone https://raw.githubusercontent.com/openstack/python-keystoneclient/stable/mitaka/tools/keystone.bash_completion
sudo wget -q -O /etc/bash_completion.d/glance https://raw.githubusercontent.com/openstack/python-glanceclient/master/tools/glance.bash_completion
