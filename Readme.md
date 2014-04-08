vagrant provision - re-do the puppet provisioning
vagrant reload - reload the whole shebang

cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku progrium"

# Installing Locally with Vagrant

Add your ssh key to Dokku so that you can deploy apps via ssh:
```bash
cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```
# Installing on a Server

# Advanced

Updating the puppet modules:
librarian-puppet update