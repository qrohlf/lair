# Lair

Lair is a set of open source web deployment tools packaged into a set of Puppet and Vagrant scripts so that you can install an awesome deployment environment locally or on a server with a single command.  Basically, Lair is your own no-configuration-required mini Heroku.

## Installation

There are two ways to install lair. If you want to use lair to test your apps locally or try out lair without setting up a server, you can install it locally using Vagrant. If you've got a server to run Lair on, you can set it up with a single command using Puppet.

## Installing Locally with Vagrant

### Prerequisites:
- [Vagrant](http://www.vagrantup.com/downloads.html)

Add your ssh key to Dokku so that you can deploy apps via ssh:
```bash
cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```
## Installing on a Server
```bash
FQDN='kerouac.qrohlf.com' wget -qO- https://raw.github.com/qrohlf/lair/master/bootstrap.sh | sudo bash
```

```bash
cat ~/.ssh/id_rsa.pub |ssh you@yourserver.com "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

## Advanced

Updating the puppet modules:
librarian-puppet update

## Troubleshooting

### "Remote host verification has changed" Errors
If you were previously running a different VM at the same address, ssh is going to complain since the host keys for the vm that Vagrant generates are different.

The solution is to just remove the outdated keys:
```bash
ssh-keygen -R [localhost]:2222 && ssh-keygen -R lair.local
```

### The "Executing 'make install'" provisioning step takes a long time
It's supposed to; dokku is downloading a 350MB VM image in the background. Just sit tight and let the provisioning scripts do their thing.

### Git/ssh asks me for a password when I try to deploy
You probably haven't added your ssh key to Dokku. Make sure to run this on your local machine to upload your key:

```bash
cat ~/.ssh/id_rsa.pub |ssh you@yourserver.com "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

or, if you're running Lair locally with Vagrant:

```bash
cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```