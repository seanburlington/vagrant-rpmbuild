class base {

  group { "puppet":                                                                                                                                                                                                                                                        
    ensure => "present",                                                                                                                                                                                                                                                   
}                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                          
File { owner => 0, group => 0, mode => 0644 }                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                          
file { '/etc/motd':                                                                                                                                                                                                                                                      
  content => "Welcome to your virtual machine!  (Managed by Puppet)

This VM should be ready to build rpms and work as a yum repo

To build the demo rpm and publish it locally run

/vagrant/build-rpm.sh  

(NB the password for the key is 'secret')


If you want to generate your own gpg key run

/vagrant/generate-gpg-key.sh

This should be a useful starting point, modify these scripts to go forward. 
"                                                                                                                                                                                                                                      
}                                                                                                                                                                                                                                                                        


package {"wget":
      ensure => present,
}

package {"man":
      ensure => present,
}

}
