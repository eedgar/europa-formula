echo "Updating, Upgrading and installing Puppet"
CODENAME=$(lsb_release -c | cut -f2)
cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-$CODENAME.deb
dpkg -i puppetlabs-release-$CODENAME.deb
apt-get update && apt-get -y install puppet
echo "Installing RGEN"
gem install rgen
