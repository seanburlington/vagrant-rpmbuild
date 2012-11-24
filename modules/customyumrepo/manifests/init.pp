class customyumrepo { 
package {"createrepo":
       ensure => present,
}


package {"httpd":
   ensure => present,
}


service {httpd:
     ensure => running,
     enable => true,
     hasstatus => true,
     hasrestart => true,
}

file {'/var/www/html/repo':
   owner => "vagrant",
   group => "vagrant",
   mode => "755",
   ensure => "directory",
   require => Package['httpd'],
   notify => Exec['make-repo'],
}

file {'/etc/httpd/conf.d/custom-repo.conf':
    owner => "root",
    group => "root",
    mode => "644",
    ensure => "file",
    require => File['/var/www/html/repo'],
    content => 'Alias /repo/ /var/www/html/repo/
',
    notify => Service['httpd'],
}



package {'iptables':
           ensure => present,
}

service {'iptables': 
     ensure => running,
     enable => true,
     hasstatus => true,
     hasrestart => true,
}


file {'/etc/sysconfig/iptables':
    owner => "root",
    group => "root",
    mode => "600",
    ensure => "file",
    require => Package['iptables'],
    content => '# Firewall configuration written by PUPPET
# Manual customization of this file is not recommended.

*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --source 10.0.2.0/24 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp  -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
',
    notify => Service['iptables'],
}


Exec {
   path => ['/usr/bin/'],
   logoutput => true,
}



exec {'make-repo':
       user => 'vagrant',
       command => 'createrepo /var/www/html/repo',
       creates => '/var/www/html/repo/repodata/repomd.xml',
       require => File['/var/www/html/repo'],
}

}
