#### vagrant

export VAGRANT_EXPERIMENTAL="disks"

#### How to update CA certificates in Linux

* cp root-ca.crt /etc/pki/ca-trust/source/anchors/
* update-ca-trust extract

To disable SSL Certificate:

* config.vm.box_download_insecure = true => Add this line in Vagrantfile

* vagrant box add centos/8 -c --insecure

* -c or --clean Clean any temporary download files
* --insecure Do not validate SSL certificates
