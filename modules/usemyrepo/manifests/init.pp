class usemyrepo {

file {'/etc/yum.repos.d/my.repo':
    owner => "root",
    group => "root",
    mode => "600",
    ensure => "file",
    source => 'puppet:///modules/usemyrepo/my.repo',
}

file {'/home/vagrant/MY-RPM-GPG-KEY.pub':
    owner => "vagrant",
    group => "vagrant",
    mode => "600",
    ensure => "file",
    source => 'puppet:///modules/usemyrepo/MY-RPM-GPG-KEY.pub',
}


}
