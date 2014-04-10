#!/bin/bash
# 
# Lair installation bootstrap script by @qrohlf
# borrows heavily from https://github.com/progrium/dokku/blob/master/bootstrap.sh

# nice colorized output
log() {
    printf "\e[0;35;49m$1\e[0m\n"
}

error_msg() {
    printf "\e[0;33;49m$1\e[0m\n"
}

success() {
    printf "\e[0;32;49m$1\e[0m\n"
}

if ! which apt-get &>/dev/null; then
    error_msg "This installation script requires apt-get. For manual installation instructions, consult https://github.com/qrohlf/lair."
    exit 1
fi

if ! [[ -n $DOMAIN ]]; then
    error_msg "You need to set the DOMAIN environment variable for this installer to work!"
    exit 1
fi

log "installing dependencies"
sudo apt-get update &> /dev/null
sudo apt-get install -y software-properties-common # needed to add PPA
[[ `lsb_release -sr` == "12.04" ]] && apt-get install -y python-software-properties # needed to add PPA on 12.04

log "adding package sources"
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo add-apt-repository -y ppa:git-core/ppa # git 1.7.10 is needed for the --single-branch option

log "executing apt-get update"
sudo apt-get update &> /dev/null

log "installing more dependencies"
sudo apt-get -y install git wget 

log "installing puppet"
sudo apt-get install -y puppet-common

log "cloning lair repo"
cd ~ && test -d lair || git clone -b master --single-branch https://github.com/qrohlf/lair
cd lair

if [[ -n $LAIR_BRANCH ]]; then
    git fetch origin $LAIR_BRANCH
    git checkout origin/$LAIR_BRANCH
elif [[ -n $LAIR_TAG ]]; then
    git fetch origin $LAIR_TAG
    git checkout $LAIR_TAG
fi

log "setting fqdn to $DOMAIN"
./scripts/set-fqdn.sh $DOMAIN
log "provisioning with Puppet..."
log "this can take up to 15 minutes, so get comfortable"
FACTER_fqdn="$DOMAIN" puppet apply --modulepath modules --manifestdir manifests manifests/site.pp &> /dev/null

log "writing $DOMAIN to /home/dokku/VHOST"
echo "$DOMAIN" > /home/dokku/VHOST


echo "##############################################"
success "Lair has been installed successfully"
success "navigate to http://$DOMAIN to deploy your first app"
