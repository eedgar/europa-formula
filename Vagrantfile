# -*- mode: ruby -*-
# vi: set ft=ruby
# Requires vagrant triggers for destroy to work properly.
# vagrant plugin install vagrant-triggers

vagrant_root = File.dirname(__FILE__)
dir = "#{vagrant_root}/vagrant-additional-disk"

domain = 'example.com'

Vagrant.configure(2) do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "http://enas.familyds.com/~eedgar/opscode_ubuntu-14.04_chef-provisionerless.box"

  ## For masterless, mount your salt file root
  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  config.vm.synced_folder "salt/pillar/", "/srv/salt/pillar"
  config.vm.synced_folder ".", "/srv/formulas/europa-formula/"
  config.vm.provider :vmware_fusion do |vm|
    vm.vmx["numvcpus"] = "4"
    vm.vmx["memsize"] = "4096"
  end

#  config.trigger.after :destroy do
#    run "rm -rf #{dir}"
#  end

#  config.vm.provider :vmware_fusion do |vm|
#    vdiskmanager = '/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager'
#
#    unless File.directory?( dir )
#       Dir.mkdir dir
#    end
#
#    file_to_disk = "#{dir}/opt-serviced-var.vmdk"
#        unless File.exists?( file_to_disk )
#            `#{vdiskmanager} -c -s 20GB -a lsilogic -t 1 #{file_to_disk}`
#        end
#
#        vm.vmx['scsi0:1.filename'] = file_to_disk
#        vm.vmx['scsi0:1.present']  = 'TRUE'
#        vm.vmx['scsi0:1.redo']     = ''
#
#  end

#  config.vm.provision :shell, :inline =>
#    "set -x && " +
#    "dpkg -s btrfs-tools >/dev/null 2>&1 || sudo apt-get install -y btrfs-tools && " +
#    "mkdir -p /opt/serviced/var && " +
#    "grep -q sdb1 /proc/partitions || ( " +
#    "echo ',,83' | sfdisk -q -D /dev/sdb && " +
#    "mkfs.btrfs /dev/sdb1" +
#    ") && " +
#    "grep -q sdb1 /etc/fstab || echo '/dev/sdb1 /opt/serviced/var btrfs rw,noatime,nodatacow 0 0' >> /etc/fstab && " +
#    "grep -q /opt/serviced/var /proc/mounts || mount /opt/serviced/var"

#  if Vagrant.has_plugin?("vagrant-proxyconf")
#    config.proxy.http     = "http://192.168.190.1:3128"
#    config.proxy.https    = "http://192.168.190.1:3128"
#    config.proxy.no_proxy = "localhost,127.0.0.1"
#  end

  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end

  config.vm.define :master do |master|
    master.vm.hostname = "europa"
  end
end
