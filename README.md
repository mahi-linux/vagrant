#### vagrant

export VAGRANT_EXPERIMENTAL="disks"

#### How to update CA certificates in Linux

* cp root-ca.crt /etc/pki/ca-trust/source/anchors/
* update-ca-trust extract

To disable SSL Certificate:
config.vm.box_download_insecure = true

vagrant box add --insecure centos/8
