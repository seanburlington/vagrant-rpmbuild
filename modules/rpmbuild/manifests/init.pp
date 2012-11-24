class rpmbuild {

package {"rpm-build":
      ensure => present,
}

package {"rpmlint":
       ensure => present,
}

#to gererate randomness when creating an rpm key
package {"rng-tools":
       ensure => present,
}



#mkdir BUILD RPMS SOURCES SPECS SRPMS          
file {"/home/vagrant/rpmbuild":
   owner => "vagrant",
   group => "vagrant",
   mode => "700",
   ensure => "directory",
}

file {"/home/vagrant/rpmbuild/BUILD":
   owner => "vagrant",
   group => "vagrant",
   mode => "700",
   ensure => "directory",
}

file {"/home/vagrant/rpmbuild/RPMS":
   owner => "vagrant",
   group => "vagrant",
   mode => "700",
   ensure => "directory",
}
   
file {"/home/vagrant/rpmbuild/SOURCES":
   owner => "vagrant",
   group => "vagrant",
   mode => "700",
   ensure => link,
   target => '/vagrant/SOURCES',
   require => File['/home/vagrant/rpmbuild'],
}


file {"/home/vagrant/rpmbuild/SRPMS":
   owner => "vagrant",
   group => "vagrant",
   mode => "700",
   ensure => "directory",
}


file {"/home/vagrant/rpmbuild/SPECS/":
   owner => "vagrant",
   group => "vagrant",
   mode => "600",
   ensure => link,
   target => "/vagrant/SPECS",
   require => File['/home/vagrant/rpmbuild'],
}


file {'/home/vagrant/.rpmmacros':
   owner => "vagrant",
   group => "vagrant",
   mode => "600",
   ensure => file,
   content => ' %_signature gpg
%_gpg_name example
',
}

package {'make':
    ensure => present,
}




Exec {
   path => ['/usr/bin/'],
   logoutput => true,
}

exec {'gpg-key':
    user => 'vagrant',
    command => 'gpg --import /home/vagrant/MY-RPM-GPG-KEY.secret',
    creates => "/home/vagrant/.gnupg/secring.gpg",
    require => File['/home/vagrant/MY-RPM-GPG-KEY.secret'],
}

file {'/home/vagrant/MY-RPM-GPG-KEY.secret':
   owner => "vagrant",
   group => "vagrant",
   mode => "600",
   ensure => file,
   source => 'puppet:///modules/rpmbuild/MY-RPM-GPG-KEY.secret', 
}

}

