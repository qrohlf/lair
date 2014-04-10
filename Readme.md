# Lair is the simplest way to install a Heroku-like environment on your own box

<p align="center">
  <img src="./images/terminal.gif" class="demo" alt="demo video" />
</p>

Lair is a Platform as a Service provider that you can install on your server or development machine with a single command.  

Lair lets you get your latest code up and running with a simple `git push`, and even includes a realtime activity monitor, so you can see what's going on under the hood, from the comfort of your browser.

Basically, Lair is your own personal Heroku-in-a-box.

# Features

- Git powered deployments with [dokku](https://github.com/progrium/dokku)
- Buildpack support via [buildstep](https://github.com/progrium/buildstep)
- Real-time server statistics with [scout_realtime](https://github.com/scoutapp/scout_realtime)
- Painless updates through git and puppet

# Installation

There are three ways to install Lair:

- You can use the `bootstrap.sh` script to install Lair on a server with a single command
- You can install Lair locally with Vagrant to try it out without needing a server, or to test your apps on your local machine
- You can install Lair manually using puppet-apply

Each of these methods is explained below

## Installing on a Server with bootstrap.sh
Before installing Lair on your server, make sure your server environment is supported. Lair is built and tested using an Ubuntu 12.04.4 x64 DigitalOcean Droplet, but it should work on any server provided you're running a fresh copy of Ubuntu 13.04 or 12.04 x64 (13.10 is **not** supported due to a known issue with docker).

To install Lair, ssh into your server and run the installer:

```bash
DOMAIN='yourdomain.com' wget -qO- https://raw.github.com/qrohlf/lair/master/bootstrap.sh | sudo bash
```

Once Lair finishes installing, head over to http://yourdomain.com to deploy your first app!

## Installing Locally with Vagrant
First, make sure you have [Vagrant](http://www.vagrantup.com/downloads.html) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) installed on your machine.

Then, clone the repo and start Vagrant:

```bash
git clone https://github.com/qrohlf/lair.git
cd lair
vagrant up
```

Once Lair finishes installing, head over to [http://lair.local](http://lair.local) to deploy your first app!

## Installing Manually
Lair is really just a collection of Puppet scripts and modules, so it should be really easy to get it working on any machine that has puppet installed. 

Assuming you have Puppet already installed, all you need to do to get Lair up and running is:

```bash
export DOMAIN='yourdomain.com'
git clone https://github.com/qrohlf/lair
cd lair
./set-fqdn.sh $DOMAIN
FACTER_fqdn="$DOMAIN" puppet apply --modulepath modules --manifestdir manifests manifests/site.pp
```

Once Lair finishes installing, head over to http://yourdomain.com to deploy your first app!

# Deploying to Lair

## SSH Key Setup
You'll need to add an ssh key to Lair for each machine you want to deploy from. You'll only need to run this command once per machine.  
(note: run this on your development machine - not on the server)

```bash
cat ~/.ssh/id_rsa.pub |ssh you@yourdomain.com "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

If you're using Lair locally with Vagrant, run this command instead:

```bash
cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

## Pushing Changes with Git

First, add a git remote pointing to Lair (this only needs to be done once per repo). Replace `yourdomain.com` with your domain, or `lair.local` if you're running Lair locally.

```bash
git remote add lair dokku@yourdomain.com:subdomain 
```

Then, whenever you have changes to deploy just push them to the lair remote:

```bash
# make some changes to your app
git commit -m "awesome new feature"
git push lair master
# that's it!
```

# Credits
Lair is actually just a bundle that brings together several excellent tools into one environment. The following people and tools do most of the heavy lifting:

- [progrium/dokku](https://github.com/progrium/dokku) handles application building and deployment
- [scout/scout_realtime](https://github.com/scoutapp/scout_realtime) provides the nice activity monitor
- [Vagrant](http://www.vagrantup.com) handles VM creation and management
- [Puppet](https://puppetlabs.com) is the glue that holds it all together
- I also was inspired by [Vagrantpress](http://vagrantpress.org) and used their puppet scripts as a reference while I was writing some of the modules used in Lair.

# Troubleshooting

See the Lair [Wiki](https://github.com/qrohlf/lair/wiki/Troubleshooting) for help with troubleshooting.

# Contributing

Pull requests are welcome! Fork Lair on [Github](https://github.com/qrohlf/lair/fork)