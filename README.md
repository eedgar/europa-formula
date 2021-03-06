Description
===========
europa development environment

## Getting Started
This guide will walk you through setting up as a developer for Europa.
The installation is setup for a Mac OS X machine and may not work for
other development environments.

### Creating a base box
A base box can be generated locally if desired using the packer script
provided within the packer folder.  The vagrant_config.yml file uses a
locally generated base box.  This can be re-configured with any URI if
desired.

```(cd packer && packer build template.json)```

```vagrant box add --force europa packer/boxes/zenoss_ubuntu-14.04_amd64.vmware.box --provider=vmware_desktop```

```vagrant box add --force europa packer/boxes/zenoss_ubuntu-14.04_amd64.virtualbox.box --provider=virtualbox```


### Configuring Vagrant
Vagrant may be configured using the `vagrant_config.yml` file.

```subl vagrant_config.yml```


### Configuring Salt
The salt recipe included within requires updating.

```(cd salt/pillar && cp europa.sls.example europa-private.sls)```

```subl salt/pillar/europa-private.sls```


### Running Vagrant
Now that a base box has been generated, it can be used to startup a Europa
instance.

To start the process, simply run:

```vagrant destroy --force; vagrant up; vagrant ssh```


## Pre-Installation Packages

### Automated:
TODO: Setup an install script

### Manual:
Thes steps listed below are the manual steps to setup the programs

#### [Homebrew](http://brew.sh): Homebrew is a package manager for Mac OS X.
```ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```

#### [Homebrew-Cask](https://github.com/caskroom/homebrew-cask): Homebrew cask wraps commonly installed programs (e.g. vmware, vagrant, etc.)
```brew install caskroom/cask/brew-cask ```

#### [Salt](http://docs.saltstack.com/en/latest/topics/installation/): Salt is configuration management solution for deploying virtual machines
```brew install salt```

#### [Git](http://git-scm.com/downloads): Git is a software configuration management system
```brew install git```

#### [Github plugin](https://github.com/github/hub): Github is a software repository hosting website
```brew install hub```

#### [Packer](https://www.packer.io/downloads.html): Packer is a vagrant box building tool
```brew install packer```

#### [Virtualbox](https://www.virtualbox.org/wiki/Downloads): Virtualbox is the standard (free) vagrant box provider; vmware runs faster
```brew cask install virtualbox```

#### [VMWare](https://my.vmware.com/web/vmware/info/slug/desktop_end_user_computing/vmware_fusion/7_0): VMWare Fusion is the industry standard for virtual machines on Mac
```brew cask install vmware-fusion```

#### [Vagrant](https://www.vagrantup.com/downloads.html): Vagrant provides a convenient mechanism to create, start and stop virtual machines
```brew cask install vagrant```

#### Vagrant: Plugins:
Vagrant plugins are used to enhance the vagrant environment

##### [VMWare](http://www.vagrantup.com/vmware): The VMWare integration allows vagrant to control vmware boxes
Note: You must have purchased a license (license.lic) before running this

```vagrant plugin install vagrant-vmware-fusion```

```vagrant plugin license vagrant-vmware-fusion license.lic```

#### [Sahara](https://github.com/jedi4ever/sahara): The Vagrant Sahara plugin is a snapshot manager
```vagrant plugin install sahara```



# update mac's /etc/hosts to have a line like this with the 4 zd entries
#127.0.0.1   localhost zd hbase.zd zenoss5.zd opentsdb.zd
