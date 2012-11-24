


Summary:                A test package for demonstration purposes
License:                GPL
Name:                   demo
Version:                0.0.1
Release:                1
Source:                 demo.tar.gz
Packager:               Bob <bob@example.com>

%description 
Very simple package, just to demonstrate rpm building

%prep
rm -rf %{buildroot}
tar -xzf %{_sourcedir}/demo.tar.gz

%install 
mkdir -p %{buildroot}/usr/share/demo
cp -r %{_builddir}/demo.txt %{buildroot}/usr/share/demo







%files
/usr/share/demo
