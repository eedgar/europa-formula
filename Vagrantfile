# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

config_filepath = File.expand_path("vagrant_config.yml",
                                   File.dirname(__FILE__))
settings = YAML.load_file config_filepath

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  settings.each do |name, cfg|
    config.vm.define name do |agent|
      agent.vm.box = name
      agent.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
      if cfg.has_key?("forwards")
        cfg["forwards"].each do |port|
          host = "vagrant"
          guest = "vagrant"
          if port.has_key?("guest")
            guest = port["guest"]
          end
          if port.has_key?("host")
            host = port["host"]
          end
          agent.vm.network "forwarded_port", guest: guest, host: host, id: name
        end
      end
      if cfg.has_key?("shares")
        cfg["shares"].each do |sname, share|
          share["host"] = File.expand_path(share["host"])
          group = "vagrant"
          owner = "vagrant"
          host = share["host"]
          guest = share["guest"]
          if share.has_key?("group")
            group = share["group"]
          end
          if share.has_key?("owner")
            owner = share["owner"]
          end
          agent.vm.synced_folder host, guest, owner: owner, group: group, create: true
        end
      end
      agent.vm.provider :vmware_fusion do |v, override|
        # override.vm.box = name + ".vmware.box"
        override.vm.box_url = cfg["providers"]["vmware_fusion"]
        v.vmx["ethernet0.present"] = "TRUE"
        v.vmx["ethernet0.addressType"] = "static"
        v.vmx["ethernet0.linkStatePropagation.enable"] = "TRUE"
        v.vmx["ethernet0.address"] = "00:0c:29:b6:62:97"
        v.vmx["ethernet0.generatedAddress"] = nil
        cfg["properties"].each do |prop, val|
          if prop == "cpus"
            prop = "numvcpus"
          elsif prop == "memory"
            prop = "memsize"
          end
          v.vmx[prop] = val
        end
        if cfg.has_key?("ip")
          v.vmx['ethernet0.fixed-address'] = cfg['ip']
          v.ssh.host = cfg['ip']
        end
      end
      agent.vm.provider :virtualbox do |v, override|
        # override.vm.box = name + ".virtualbox.box"
        override.vm.box_url = cfg['providers']['virtualbox']
        override.vm.network :private_network, type: "dhcp"
        if cfg.has_key?("ip") and cfg["ip"] != "dhcp"
          override.vm.network :private_network, ip: cfg['ip']
        end
        cfg["properties"].each do |prop, val|
          if prop == "numvcpus"
            prop = "cpus"
          elsif prop == "memsize"
            prop = "memory"
          end
          v.customize ["modifyvm", :id, "--#{prop}", "#{val}"]
        end
      end
      if cfg.has_key?("ssh_keys")
        cfg["ssh_keys"].each do |name, data|
          if data.has_key?("private_key_path")
            key_path = data["private_key_path"]
            key_path = File.expand_path(key_path, __FILE__)
            shell_cmd = "ssh-add -L | grep " + key_path + " > /dev/null"
            ssh_path_added = system(shell_cmd)
            if not ssh_path_added
              add_cmd = "ssh-add " + key_path
              puts("Running cmd on host: " + add_cmd)
              ssh_path_added = system(add_cmd)
            end
            if ssh_path_added
              agent.ssh.private_key_path = key_path
              agent.ssh.forward_agent = true
              agent.ssh.username = "vagrant"
              agent.ssh.password = "vagrant"
              if data.has_key?("username")
                agent.ssh.username = data["username"]
              end
              if data.has_key?("password")
                agent.ssh.password = data["password"]
              end
            end
          end
        end
      end
      if cfg.has_key?("provisions")
        cfg["provisions"].each do |prov|
          agent.vm.provision prov["provision"] do |p|
            # setup keys that do not directly map
            if prov.has_key?('recipes')
              prov["recipes"].each do |r|
                p.add_recipe r
              end
              prov.delete("recipes")
            end
            # setup 1:1 mapping keys
            prov.each do |key, val|
              if key != 'provision'
                p.instance_variable_set("@#{key}", val)
              end
            end
          end
        end
      end
    end
  end
end
