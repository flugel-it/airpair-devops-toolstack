Chef repo - flugel.it
=====================

https://bitbucket.org/flugel-it/chef-repo.git

The skeleton of the Chef repo used by us.

We use bundle to install deps declared in Gemfile and librarian-chef to install
Chef community cookbooks.

File layout
-----------

* **cookbooks**: This directory is for community cookbooks only.
* **site-cookbooks**: This directory is for cookbooks developed by us.

The other ones are self-explanatory if you have experience with Chef :)

How to prepare a box to develop using Chef
------------------------------------------

Login into the instance using "ssh -A" to forward your authentication keys.
If you want to use Vagrant, first run this commands:

```
vagrant up
vagrant ssh
sudo -i
cd /vagrant
```

Now, in any case run:

```
yum install -y git make screen redhat-lsb-core
```

or

```
apt-get install -y git make screen lsb-release
```

```
git clone git@bitbucket.org:flugel-it/chef-repo.git
cd chef-repo
make install-chef-client
```

On Vagrant you only need the last command.

Applying recipes or roles
-------------------------

```
chef-client -z -r 'role[role_name]' -c .chef/client.rb
```

or

```
chef-client -z -r 'recipe[cookbook_name]' -c .chef/client.rb
```

As you can see (-z) we are using Chef local mode to test recipes.

Install community cookbooks
---------------------------

Edit the Cheffile and add the cookbooks that you need. Then run:

```
librarian-chef install
```

Remember to commit all the changes in the repo, specially the Cheffile.lock.

Updating community cookbooks
----------------------------

To update all the cookbooks run:

```
librarian-chef update
```

To update a specific one run:

```
librarian-chef update ${COOKBOOK}
```

Ruby dependencies
-----------------

Ruby dependencies are managed by bundle. If you need a new Ruby gem, add it to
the Gemfile and run:

```
bundle install
```

To update gems:

```
bundle update
```

To update one gem

```
bundle update ${GEM}
```

Always remember to commit the Gemfile.lock

Credits
-------

infradevs@flugel.it

