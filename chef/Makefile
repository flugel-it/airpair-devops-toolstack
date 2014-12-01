IP:=$(shell ip r sh scope link | cut -f9 -d" ")
HOSTNAME:=$(shell hostname)
PWD:=$(shell pwd)

OSRELEASE:=$(shell lsb_release -sc)
OSNAME:=$(shell lsb_release -si)

ifeq ($(OSRELEASE),precise)
RUBYPKG:=ruby1.9.1-full ruby1.9.1-dev
else
RUBYPKG:=ruby ruby-dev
endif

osdeps:
ifeq ($(OSNAME),Ubuntu)
	apt-get update
	dpkg -l |grep ruby | awk '{ print $$2; }' | \
		xargs apt-get remove --purge --yes --force-yes
	apt-get install -y $(RUBYPKG) python-setuptools bundler
else
	yum install -y ruby ruby-devel gcc glibc-devel rubygems \
		python-setuptool
	gem install ffi -v '1.9.6'
	gem install bundle --no-rdoc --no-ri
endif
	bundle install
	gem install librarian-chef
	easy_install pip

fixhosts:
	echo 127.0.0.1 localhost.localdomain localhost > /etc/hosts
	echo $(IP) $(HOSTNAME).socialoptimizr.com $(HOSTNAME) >> /etc/hosts

librarian-install:
	librarian-chef install --path cookbooks

librarian-update:
	librarian-chef update --path cookbooks

/usr/bin/salt-master:
	test -d /etc/salt || mkdir /etc/salt
	ln -sf $(PWD)/salt/install_salt.sh /etc/salt/install_salt.sh
	sh /etc/salt/install_salt.sh -L -M -P git v2014.7.0rc1
	#curl -L https://bootstrap.saltstack.com -o /etc/salt/install_salt.sh

salt: /usr/bin/salt-master
	ln -sf $(PWD)/salt/cloud.providers /etc/salt/cloud.providers
	ln -sf $(PWD)/salt/cloud.profiles /etc/salt/cloud.profiles
	ln -sf $(PWD)/salt/dossh.pem /etc/salt/dossh.pem
	chmod 400 /etc/salt/dossh.pem
	chmod 400 salt/dossh.pem 
	test -d /etc/salt/master.d || mkdir /etc/salt/master.d
	sed "s%_PWD_%$(PWD)%" salt/master-local.conf > \
		/etc/salt/master.d/local.conf
	service salt-master restart

deps: osdeps librarian-install

/usr/bin/chef-client: deps
	wget -O /tmp/install-chef.sh \
		https://www.opscode.com/chef/install.sh
	bash /tmp/install-chef.sh

/opt/chef-server/bin/chef-server-ctl: deps install-client
	chef-client -z -r 'role[chef-server]' -c .chef/client.rb

install-chef-server: /opt/chef-server/bin/chef-server-ctl salt

install-chef-client: /usr/bin/chef-client

upload:
	knife upload cookbooks
	knife upload roles
	knife upload nodes
	knife upload environments
	knife upload data_bags

download:
	knife download cookbooks
	knife download roles
	knife download nodes
	knife download environments
	knife download data_bags

.PHONY: salt

