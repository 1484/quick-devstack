# demo.sh - Devstack extras script to setup demo env

if [[ "$1" == "source" ]]; then
    if [[ "$OFFLINE" != "True" ]]; then
        git pull
    fi
elif [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
    :
elif [[ "$1" == "stack" && "$2" == "install" ]]; then
    if is_service_enabled c-bak; then
        install_database_python
    fi
elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
    :
elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
    :
fi

if [[ "$1" == "unstack" ]]; then
    :
fi

if [[ "$1" == "clean" ]]; then
    :
fi
