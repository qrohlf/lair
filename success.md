---
layout: default
title: Congratulations!
subtitle: Lair has been succesfully installed on your machine
permalink: /success/index.html
---

# You did it!
Lair is now running on this machine. **Time to deploy some apps!**

# But first, add some SSH Keys
In order to deploy apps with git, you'll need to add your SSH keys to the list of authorized users. Don't worry, it only takes one command!

If you have installed Lair to a server using bootstrap.sh or puppet, run this command (replacing you@yourserver.com with your server's ssh info):

```bash
cat ~/.ssh/id_rsa.pub |ssh you@yourserver.com "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

If you have installed Lair to your local machine using Vagrant, run this following command:

```
cat ~/.ssh/id_rsa.pub |ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost "sudo sshcommand acl-add dokku '$USER@$HOSTNAME'"
```

You're now ready to deploy your first app to Lair!

# Deploying an App

Lair uses git to deploy apps - just add a remote pointing to dokku@yourserver.com (or lair.local if you're running locally). Any changes pushed to that remote will be automatically deployed!

```bash
git remote add lair dokku@yourserver.com:subdomain # replace "subdomain" with the subdomain that you'd like your app to be available at
git push lair master
```

For more information about deploying apps like how to set environment variables for your apps and use custom buildpacks, see the README and documentation for [dokku](https://github.com/progrium/dokku). (Dokku does all the heavy lifting in Lair when it comes to deployment.)