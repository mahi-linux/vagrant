#### vagrant

export VAGRANT_EXPERIMENTAL="disks"

#### How to update CA certificates in Linux

Ref: https://manuals.gfi.com/en/kerio/connect/content/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html

* cp root-ca.crt /etc/pki/ca-trust/source/anchors/
* update-ca-trust extract

To disable SSL Certificate:

* config.vm.box_download_insecure = true => Add this line in Vagrantfile

* vagrant box add centos/8 -c --insecure

* -c or --clean Clean any temporary download files
* --insecure Do not validate SSL certificates

##### Virtual Box error 
* Error Message: Progress state: NS_ERROR_FAILURE
* VBoxManage: error: Failed to create the host-only adapter

* sudo "/Library/Application Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh" restart 
* Adjust the privacy settings of Big Sur: System Preferences > Security and Privacy > click the allow button. => Then reboot the MAC.

* For Windows Machines, simply disable network adopter and enable from the device manager.
* if the above solution doesn't work then run vagrant up as an Administrator.

##### To connect from local machine with root account
```
# vi /etc/ssh/sshd_config
PasswordAuthentication no => yes

# sshd -t
# systemctl restart sshd

Then try accessing from local machine
```
