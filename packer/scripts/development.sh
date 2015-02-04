apt-get install -y curl
apt-get install -y nfs-kernel-server
apt-get install -y nfs-common
apt-get install -y net-tools
apt-get install -y apt-transport-https

apt-get install -y bash-completion
apt-get install -y git
apt-get install -y ruby
apt-get install -y git-flow
apt-get install -y tmux
apt-get install -y screen
apt-get install -y vim
apt-get install -y mosh
apt-get install -y vcsh
apt-get install -y mr
apt-get install -y vim-syntax-docker
apt-get install -y vim-python-jedi
apt-get install -y vim-scripts
apt-get install -y python-flake8
apt-get install -y python-autopep8
apt-get install -y python-virtualenv
apt-get install -y python-pip
apt-get install -y python-tox
apt-get install -y virtualenvwrapper
apt-get install -y fabric
apt-get install -y python-pexpect
apt-get install -y python-setuptools
apt-get install -y subversion

gem install tmuxinator

curl http://stedolan.github.io/jq/download/linux64/jq -o /usr/bin/jq && chown root:root /usr/bin/jq && chmod a+x /usr/bin/jq