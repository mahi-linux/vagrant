# Installing Foreman 2.4 server with Katello 4.0 plugin on Enterprise Linux
# Reference: https://docs.theforeman.org/2.4/Installing_Server_on_Red_Hat/index-katello.html
# Prerequisites
Foreman version: 2.4
Katello Version: 4.0
OS: CentOS8
Data Disk Size: 1TB
CPU: 2
Memory: 8GB

# LVM Configuration: 
dnf install -y lvm2
pvcreate /dev/sdb ; vgcreate vg_data /dev/sdb
lvcreate -L +5GB vg_data -n log
lvcreate -L +5GB vg_data -n pgsql
lvcreate -L +2GB vg_data -n puppetlabs
lvcreate -L +200GB vg_data -n pulp
lvcreate -L +2GB vg_data -n qpidd

for i in $(lvscan | grep vg_data | cut -d "'" -f2); do mkfs.xfs $i; done

mkdir -p /var/lib/pgsql; mkdir -p /opt/puppetlabs; mkdir -p /var/lib/qpidd; mkdir -p /var/lib/pulp

cat <<EOF>>/etc/fstab
#Foreman File Systems
/dev/vg_data/log /var/log xfs defaults 0 0
/dev/vg_data/pgsql /var/lib/pgsql xfs defaults 0 0
/dev/vg_data/puppetlabs /opt/puppetlabs xfs defaults 0 0
/dev/vg_data/pulp /var/lib/pulp/ xfs defaults 0 0
/dev/vg_data/qpidd /var/lib/qpidd/ xfs defaults 0 0
EOF

# Mount the FS
mount -a

# Disable Firewall rules
yum remove -y firewalld

#Update host entry
sed -i '/sal-foremanp01/d' /etc/hosts
echo "192.168.10.20 sal-foremanp01.example.in sal-foremanp01" >>/etc/hosts

# Configure ForeMan Server Repo
dnf clean all
dnf localinstall -y https://yum.theforeman.org/releases/2.4/el8/x86_64/foreman-release.rpm
dnf localinstall -y https://yum.theforeman.org/katello/4.0/katello/el8/x86_64/katello-repos-latest.rpm
dnf localinstall -y https://yum.puppet.com/puppet6-release-el-8.noarch.rpm
dnf config-manager --set-enabled powertools

dnf module reset ruby -y
dnf module enable ruby:2.5 -y
dnf module reset postgresql -y
dnf module enable postgresql:12 -y
dnf --allowerasing distro-sync -y

# Install ForeMan Server Packages
dnf update -y
dnf install -y foreman-installer-katello

# Configure System Clock with Chronyd
yum install -y chrony
systemctl --now enable crond

# Configure ForeMan
foreman-installer --scenario katello \
--foreman-initial-organization “sal-foremanp01.example.in" \
--foreman-initial-location “India” \
--foreman-initial-admin-username admin \
--foreman-initial-admin-password F0reman!
