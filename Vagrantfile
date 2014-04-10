VAGRANTFILE_API_VERSION = "2"
ENV['FQDN'] ||= "lair.local"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.hostname = ENV['FQDN']
  config.vm.network :private_network, ip: "10.1.1.2"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision :shell do |shell|
    shell.path = 'scripts/set-fqdn.sh'
    shell.args = ENV['FQDN']
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path   = "modules"
    # puppet.options="--verbose --debug"
    puppet.facter = {fqdn: ENV['FQDN']}
  end

  config.vm.provision :shell do |shell|
    shell.inline = "sudo rm -f /home/dokku/VHOST"
  end

end
