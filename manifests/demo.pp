# puppet stages are of limted use - but defining repositories at the right point seems to be valid
stage { 'last': }
    Stage['main'] -> Stage['last']

# setup some basic stuff
include base

# setup to build rpms
include rpmbuild  

# configure apache etc for serving yum
include customyumrepo


# configure yum to use the new repo  
#include usemyrepo
class { 'usemyrepo':
  stage => last, # making sure we don't define the repo until it is created - otherwise yum breaks
}


# Now all you need to do is build some packages, copy them to the repo directory and rum createrepo on it (see /vagrant/build-rpm.sh for an example)


