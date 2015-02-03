Description
===========
europa development environment

## Getting Started
This guide will walk you through setting up as a developer for Europa.
The installation is setup for a Mac OS X machine and may not work for
other development environments.

## Installation

### Automated:
TODO: Setup an install script

### Manual:
Thes steps listed below are the manual steps to setup the programs

#### Homebrew: [url]()
Homebrew is a package manager for Mac OS X.
Install Homebrew:

```ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```

#### Homebrew-Cask: [url]()
Homebrew cask wraps commonly installed programs (e.g. vmware, vagrant, etc.)
Install via homebrew:

```brew install caskroom/cask/brew-cask ```

#### Salt: [url](http://docs.saltstack.com/en/latest/topics/installation/)
Salt is configuration management solution for deploying virtual machines
Installing via homebrew:

```brew install salt```

#### Git: [url](http://git-scm.com/downloads)
Install via homebrew:

```brew install git```

#### Github plugin: [url](https://github.com/github/hub)
Install via homebrew:

```brew install hub```

#### Packer: [url](https://www.packer.io/downloads.html)
Packer is a vagrant box building tool
Installing via homebrew:

```brew install packer```

#### Virtualbox: [url](https://www.virtualbox.org/wiki/Downloads)
Virtualbox is the standard (free) vagrant box provider; vmware runs faster
Installing via homebrew-cask:

```brew cask install virtualbox```

#### VMWare: [url](https://my.vmware.com/web/vmware/info/slug/desktop_end_user_computing/vmware_fusion/7_0)
VMWare Fusion is the industry standard for virtual machines on Mac
Install via homebrew-cask:

```brew cask install vmware-fusion```

#### Vagrant: [url](https://www.vagrantup.com/downloads.html)
Vagrant provides a convenient mechanism to create, start and stop virtual machines
Install via homebrew-cask:

```brew cask install vagrant```

#### Vagrant: Plugins:
Vagrant plugins are used to enhance the vagrant environment

##### VMWare: [url](http://www.vagrantup.com/vmware)
The VMWare integration allows vagrant to control vmware boxes
Note: You must have purchased a license (license.lic) before running this

```vagrant plugin install vagrant-vmware-fusion

vagrant plugin license vagrant-vmware-fusion license.lic```

#### Sahara: [url](https://github.com/jedi4ever/sahara)
The Vagrant Sahara plugin is a snapshot manager

```vagrant plugin install sahara```

