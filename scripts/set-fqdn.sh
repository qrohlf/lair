hostentry="127.0.0.1 $1 ${1%%.*}"
if grep --quiet "$hostentry" /etc/hosts; then
    echo "hosts file fqdn configured correctly"
else
    # echo "$hostentry" >> /etc/hosts
    echo "added fqdn entry '$hostentry' to host file"
fi