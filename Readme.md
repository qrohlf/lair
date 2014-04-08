## Installing Locally with Vagrant

### Prerequisites:
- [Vagrant](http://www.vagrantup.com/downloads.html)

Add your ssh key to Dokku so that you can deploy apps via ssh:
```bash
cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```
## Installing on a Server
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
ssh-keygen -R [localhost]:2222 && ssh-keygen -R wardenclyffe.local
```

### The "make install" provisioning step takes a long time
It's supposed to; dokku is downloading a decently-sized VM image in the background. Just sit tight and let the provisioning scripts do their thing.

### Git/ssh asks me for a password when I try to deploy
You probably haven't added your ssh key to Dokku. Make sure to run this on your local machine to upload your key:

```bash
cat ~/.ssh/id_rsa.pub |ssh you@yourserver.com "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

or, if you're running Wardenclyffe locally with Vagrant:

```bash
cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

# DigitalOcean Install Notes
- Spin up a 12.04 x64 droplet
- Follow instructions for installing puppet at http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-debian-and-ubuntu

```
ssh root@192.241.227.65
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get install puppet-common
sudo apt-get install git
git clone https://github.com/qrohlf/Wardenclyffe.git
cd Wardenclyffe
FACTER_fqdn='kerouac.qrohlf.com' puppet apply --verbose --debug --modulepath modules --manifestdir manifests --detailed-exitcodes manifests/site.pp
```