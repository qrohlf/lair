VAGRANTFILE_API_VERSION = "2"

# fix for vagrant not setting the FQDN correctly in the hosts file
hostentry = "127.0.0.1 wardenclyffe.local wardenclyffe"
fqdn = <<SCRIPT
if grep --quiet '#{hostentry}' /etc/hosts; then
    echo "hosts file configured correctly"
else
    echo '#{hostentry}' >> /etc/hosts
    echo "added fqdn to host file"
fi
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.hostname = "wardenclyffe.local"
  config.vm.network :private_network, ip: "10.1.1.2"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision :shell do |shell|
    shell.inline = fqdn
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path   = "modules"
    puppet.options="--verbose --debug"
    puppet.facter = {fqdn: 'wardenclyffe.local'}
  end

  config.vm.provision :shell do |shell|
    shell.inline = "sudo rm -f /home/dokku/VHOST"
  end

end
