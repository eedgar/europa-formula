# https://github.com/control-center/serviced/wiki/Install-a-Build:-Ubuntu,-Master
# https://github.com/zenoss/solutions-private/wiki

{% set host = salt['grains.get']('host') %}
{% set ip = salt['grains.get']('ip_interfaces:eth0')[0] %}
{% set sourcedir = '/home/zenoss/src' %}
{% set docker_image = 'zenoss/serviced-isvcs\:v26' %}
{% set europa = salt['pillar.get']('europa', {}) %}

{{ host }}:
  host.present:
    - ip: {{ ip }}
    - names:
        - zenoss5.{{ host }}
        - opentsdb.{{ host }}
        - hbase.{{ host }}

# ufw
ufw_disable:
  cmd.run:
    - name: "ufw disable"
    - unless: "ufw status| grep 'Status: inactive'"

# docker #######################################################################
docker-dependencies:
  pkg.installed:
    - names:
      - curl
      - nfs-kernel-server
      - nfs-common
      - net-tools
      - apt-transport-https

## Helpful user utilities
user-dependencies:
   pkg.installed:
     - names:
       - git
       - ruby
       - git-flow
       - tmux
       - screen
       - vim
       - mosh
       - vcsh
       - mr
       - vim-syntax-docker
       - vim-python-jedi
       - vim-gocomplete
       - vim-scripts
       - python-flake8
       - python-autopep8
       - python-virtualenv
       - python-pip
       - python-tox
       - virtualenvwrapper
       - fabric
       - python-pexpect
       - python-setuptools
       - subversion

tmuxinator:
  cmd.run:
    - name: "gem install tmuxinator"
    - unless: "test -x /usr/local/bin/tmuxinator"
    - require:
        - pkg: user-dependencies

jq:
  cmd.run:
    - name: "curl http://stedolan.github.io/jq/download/linux64/jq -o /usr/bin/jq && chown root:root /usr/bin/jq && chmod a+x /usr/bin/jq"
    - unless: "test -x /usr/bin/jq"
    - require:
        - pkg: user-dependencies

## End Helpful user utilities


docker-repo:
    pkgrepo.managed:
        - repo: 'deb https://get.docker.com/ubuntu docker main'
        - require:
          - pkg: docker-dependencies

docker-repo-key:
  cmd.run:
    - name: "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9"
    - unless: 'apt-key list | grep A88D21E9'
    - require:
        - pkgrepo: docker-repo

lxc-docker-1.3.3:
  pkg.installed:
    - refresh: True   # pick up the new info from setting the repo
    - require:
        - cmd: docker-repo-key

docker_aufs:
  cmd.run:
    - name: "stop docker && apt-get remove -y lxc-docker && apt-get -y autoremove && rm -rf /var/lib/docker && apt-get update -y && apt-get install -y linux-image-extra-`uname -r` && apt-get install -y lxc-docker-1.3.3 && start docker"
    - unless: "docker info|grep 'Storage Driver: aufs'"
    - require:
      - pkg: lxc-docker-1.3.3

# zenoss user/group
z_zenoss_group:
    group:
        - name: zenoss
        - present
        - gid: 1206

# install this group so that sudo works in the aws env out of the box
z_awsadmins_group:
    group:
        - name: awsadmins
        - present
        - gid: 1001

z_zenoss_user:
    user:
        - name: zenoss
        - present
        # password: zenoss as a hash
        - password: $6$Hi2RBlyd$VAwkGTGTvy38HOUrkZbaqP9/M7XULQ1zEJ4JkbvSy0xGYu6pRBZbZkp4EGlznJYJsw.R2Wep6su1Klw.3uPRB/
        - uid: 1337
        - gid: 1206
        - shell: /bin/bash
        - groups:
            - sudo
            - docker
            - awsadmins

dockerhub-login:
  cmd.run:
    - name: docker login -u {{ pillar['europa']['dockerhub']['username'] }} -e {{ pillar['europa']['dockerhub']['email'] }} -p {{ pillar['europa']['dockerhub']['password'] }}
    - user: zenoss
    - unless: test -f ~/.dockercfg
    - require:
      - user: z_zenoss_user


ssh_keydir:
    file.directory:
      - name: /home/zenoss/.ssh/
      - user: zenoss
      - group: zenoss
      - makedirs: True
      - mode: 700
      - require:
        - user: z_zenoss_user
        - group: z_zenoss_group

{% if salt['pillar.get']('europa:ssh_keys:privkey') %}
zenoss_private_key:
  file.managed:
     - name: /home/zenoss/.ssh/id_dsa
     - user: zenoss
     - group: zenoss
     - mode: 600
     - show_diff: False
     - contents_pillar: europa:ssh_keys:privkey
     - require:
       - file: ssh_keydir
       - user: z_zenoss_user
       - group: z_zenoss_group
{% endif %}

{% if salt['pillar.get']('europa:ssh_keys:pubkey') %}
zenoss_public_key:
  file.managed:
     - name: /home/zenoss/.ssh/id_dsa.pub
     - user: zenoss
     - group: zenoss
     - mode: 644
     - show_diff: False
     - contents_pillar: europa:ssh_keys:pubkey
     - require:
       - file: ssh_keydir
       - user: z_zenoss_user
       - group: z_zenoss_group
{% endif %}

serviced-repo:
    pkgrepo.managed:
        - repo: 'deb [ arch=amd64 ] http://unstable.zenoss.io/apt/ubuntu trusty universe'

serviced-repo-key:
  cmd.run:
    - name: "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys AA5A1AD7"
    - unless: 'apt-key list | grep AA5A1AD7'
    - require:
        - pkgrepo: serviced-repo

serviced:
  pkg.installed:
    - refresh: True   # pick up the new info from setting the repo
    - require:
        - cmd: serviced-repo-key

srcdir-create:
   file.directory:
     - name: {{ sourcedir }}
     - user: zenoss
     - group: zenoss
     - require:
         - user: z_zenoss_user

bashrc_edits:
  file.blockreplace:
  - name: /home/zenoss/.bashrc
  - marker_start: "# Zenoss5x: salt managed Begin DO NOT EDIT BY HAND"
  - marker_end: "# Zenoss5x: salt managed End DO NOT EDIT BY HAND"
  - backup: '.bak'
  - content: |
     if [ -f ~/.bashrc.serviced ]; then
         . ~/.bashrc.serviced
     fi
  - append_if_not_found: True
  - show_changes: True

bashrc_serviced:
    file.managed:
      - name: /home/zenoss/.bashrc.serviced
      - source: salt://europa/bashrc.serviced
      - show_changes: True
      - backup: '.bak'
      - user: zenoss
      - group: zenoss

/etc/default/serviced:
  file.blockreplace:
     - append_if_not_found: True
     - show_changes: True
     - backup: '.bak'
     - marker_start: "# Zenoss5x: salt managed Begin DO NOT EDIT BY HAND"
     - marker_end: "# Zenoss5x: salt managed End DO NOT EDIT BY HAND"
     - content: |
        SERVICED_LOG_LEVEL=2
        SERVICED_OPTS="-mount *,{{ sourcedir }},{{ sourcedir }}"

serviced-service:
    service.running:
    - name: serviced
    - enable: True
    - require:
      - file: /etc/default/serviced

add_host:
  cmd.script:
    - source: salt://europa/add_host
    - user: zenoss
    - template: jinja
    - unless: serviced host list|grep {{ip}}
    - require:
      - service: serviced-service

git-config:
  file.managed:
    - source: salt://europa/gitconfig
    - name: /home/zenoss/.gitconfig
    - unless: test -f /home/zenoss/.gitconfig
    - template: jinja
    - user: zenoss
    - group: zenoss
    - mode: 644

{% if salt['pillar.get']('europa:extended_gitconfig', False) %}
git-config-extended:
  file.managed:
    - source: salt://europa/gitconfig_extended
    - name: /home/zenoss/.gitconfig_extended
    - unless: test -f /home/zenoss/.gitconfig_extended
    - template: jinja
    - user: zenoss
    - group: zenoss
    - mode: 644
{% endif %}

{% if salt['pillar.get']('europa:tmux_config', False) %}
tmux-config:
  file.managed:
    - source: salt://europa/tmux_config
    - name: /home/zenoss/.tmux.conf
    - unless: test -f /home/zenoss/.tmux.conf
    - template: jinja
    - user: zenoss
    - group: zenoss
    - mode: 644
{% endif %}

github-known_hosts:
  ssh_known_hosts.present:
    - name: github.com
    - user: zenoss
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
    - require:
      - file: git-config

#git@github.com:zenoss/zenoss-service.git:
#  git.latest:
#   - target: /home/zenoss/zenoss-service
#    - unless: test -d /home/zenoss/zenoss-service
#    - user: zenoss
#    - require:
#      - file: git-config
#      - ssh_known_hosts: github-known_hosts

add_template:
  cmd.script:
    - source: salt://europa/add_template
    - user: zenoss
    - template: jinja
    - unless: serviced template list|grep Zenoss.develop
    - require:
#      - git: git@github.com:zenoss/zenoss-service.git
      - cmd: add_host

deploy_template:
  cmd.script:
    - source: salt://europa/deploy_template
    - user: zenoss
    - template: jinja
    - unless: serviced service list|grep Zenoss.develop
    - require:
      - cmd: add_template

{% for repo in salt['pillar.get']('europa:gitrepos') %}
{{repo.repo}}:
  git.latest:
    - target: /home/zenoss/src/{{repo.path}}
    - unless: test -d /home/zenoss/src/{{repo.path}}
    - user: zenoss
    - require:
      - file: git-config
{% endfor %}
