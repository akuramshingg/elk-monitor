#!/bin/bash

if ! type -p rpmbuild >/dev/null; then
    echo "rpmbuild not found"

    echo "Trying to autoinstall rpm"
    if type -p apt >/dev/null; then
        sudo -n apt -y install rpm
        if [ $? -ne 0 ]; then
            echo "ERROR: auto-install failed, install rpm package manually"
            exit 1
        fi
    else
        if type -p yum >/dev/null; then
            sudo -n yum -i install rpm
            if [ $? -ne 0 ]; then
                echo "ERROR: auto-install failed, install rpm package manually"
                exit 1
            fi
        else
            echo "ERROR: don't know how to install"
            exit 1
        fi
    fi
fi

if ! type -p rpmbuild >/dev/null; then
    echo "ERROR: auto-install failed, install rpm package manually"
    exit 1
fi

function finish()
{
    if [ -f $HOME/.rpmmacros.bak ]; then
        mv -f $HOME/.rpmmacros.bak $HOME/.rpmmacros
    fi
}

if [ -f $HOME/.rpmmacros ]; then
    cp -f $HOME/.rpmmacros $HOME/.rpmmacros.bak
    trap finish EXIT
fi

CWD=$(readlink -f $(dirname $0))
echo $CWD
echo "%_topdir   ${CWD}/rpmbuild" > $HOME/.rpmmacros
echo "%_tmppath  %{_topdir}/tmp" >> $HOME/.rpmmacros

cd rpmbuild
tar -czf elkenableservices-1.0.tar.gz elkenableservices-1.0
mv elkenableservices-1.0.tar.gz SOURCES/
rpmbuild -ba SPECS/elkenableservices.spec
mv RPMS/x86_64/*.rpm ..

