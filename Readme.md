# Lair

Lair is a set of open source web deployment tools packaged into a set of Puppet and Vagrant scripts so that you can install an awesome deployment environment locally or on a server with a single command.  Basically, Lair is your own no-configuration-required mini Heroku.

For more info, see the [project page](https://qrohlf.com/lair)

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