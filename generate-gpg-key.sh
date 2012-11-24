#!/bin/bash

run on the build server to create a new key

sudo rngd -r /dev/urandom
# start the agent
gpg-agent --use-standard-socket --daemon

cat <<EOF | gpg --batch --no-tty --gen-key
%echo Generating a standard key
Key-Type: default
Key-Length: 2048
Subkey-Type: default
Subkey-Length: 2048
Name-Real: example
Name-Email: example@example.com
Expire-Date: 0
Passphrase: secret
%commit
%echo done
EOF

gpg --export -a 'example' > /vagrant/modules/usemyrepo/files/MY-RPM-GPG-KEY.pub
gpg --export-secret-keys -a 'example' > /vagrant/modules/rpmbuild/files/MY-RPM-GPG-KEY.secret


