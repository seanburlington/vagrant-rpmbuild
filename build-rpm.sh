#!/bin/bash

rpmbuild --sign -bb rpmbuild/SPECS/demo.spec 
cp rpmbuild/RPMS/x86_64/* /var/www/html/repo/
createrepo /var/www/html/repo/

