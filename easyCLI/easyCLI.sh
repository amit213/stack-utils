#!/bin/sh
#!/bin/bash
#swsh 
#author :: amit213, amit tank
#license : MIT License 
#revision history / summary.


echo "Welcome, Mr. Anderson."


#check if param is empty
is_param_empty() {
    if [[ "$@" ]]
    then
        return $_FALSE
    else
        return $_TRUE  
    fi      
}

## query the internal id for given subnet name.
get_subnet_id() {
    echo $@
    if is_param_empty "$@"
    then
        echo "you forgot to pass the param"
    else
        subnet_name=$@
        echo `neutron subnet-list | grep private-subnet | awk '{ print $2}'`
    fi
}
