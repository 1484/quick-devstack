# demo.sh - Devstack extras script to setup demo env

install_cli_bash_completion() {
    local service=$1
    local comp_file=/etc/bash_completion.d/${service}
    local source_url=http://git.openstack.org/cgit/openstack/python-${service}client/plain/tools/${service}.bash_completion?h=stable/liberty
    if [ -f $comp_file ]; then
        return
    fi
    sudo wget -q -O $comp_file $source_url
}

if [[ "$1" == "source" ]]; then
    if [[ "$OFFLINE" != "True" ]]; then
        git pull
    fi
elif [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
    sudo apt-get -y install gettext
elif [[ "$1" == "stack" && "$2" == "install" ]]; then
    for service in nova neutron cinder keystone glance; do
        install_cli_bash_completion $service
    done
elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
    cat <<EOF > /etc/neutron/dnsmasq-neutron.conf
dhcp-option-force=26,1400
EOF
elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
    :
    pofile=/usr/local/lib/python2.7/dist-packages/openstack_auth/locale/ja/LC_MESSAGES/django.po
    mofile=/usr/local/lib/python2.7/dist-packages/openstack_auth/locale/ja/LC_MESSAGES/django.mo
    if [ -f $pofile ]; then
        sudo msgfmt -o $mofile $pofile
    fi
    sudo service apache2 reload
fi

if [[ "$1" == "unstack" ]]; then
    :
fi

if [[ "$1" == "clean" ]]; then
    :
fi
