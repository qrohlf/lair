#!/bin/bash
# 
# Wardenclyffe installation bootstrap script by @qrohlf
# borrows heavily from https://github.com/progrium/dokku/blob/master/bootstrap.sh

# nice colorized output
log() {
    printf "\e[0;35;49m$1\e[0m\n"
}

error() {
    printf "\e[0;33;49m$1\e[0m"
}

if ! which apt-get &>/dev/null
then
  error "This installation script requires apt-get. For manual installation instructions, consult https://github.com/qrohlf/Wardenclyffe."
  exit 1
fi

log "adding puppet package sources"
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb

log "executing apt-get update"
sudo apt-get update

log "installing dependencies"
sudo apt-get -y install git wget build-essential software-properties-common
[[ `lsb_release -sr` == "12.04" ]] && apt-get install -y python-software-properties

log "installing puppet"
sudo apt-get install -y puppet-common

log "cloning Wardenclyffe repo"
cd ~ && test -d Wardenclyffe || git clone https://github.com/qrohlf/Wardenclyffe
cd Wardenclyffe
git fetch origin

if [[ -n $WARDEN_BRANCH ]]; then
  git checkout origin/$WARDEN_BRANCH
elif [[ -n $WARDEN_TAG ]]; then
  git checkout $WARDEN_TAG
fi

log "setting fqdn to $DOMAIN"
./set-fqdn.sh $DOMAIN
log "provisioning with Puppet... this will take a while"
FACTER_fqdn="$DOMAIN" puppet apply --verbose --debug --modulepath modules --manifestdir manifests --detailed-exitcodes manifests/site.pp