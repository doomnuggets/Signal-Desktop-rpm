%global debug_package %{nil}

%define version 1.11.0
%define pkgname signal

Name: Signal-Desktop
Version: %{version}
Source0: %{name}-%{version}.tar.gz

%if 0%{?fedora}
BuildRequires: python2, npm, node, gcc-c++, git, gtk3-devel, gtk3
Requires: python2, npm, node, gcc-c++, git, gtk3-devel, gtk3
%endif

%if 0%{?rhel}
BuildRequires: python2, gcc-c++, git, gtk3-devel, gtk3
Requires: python2, gcc-c++, git, gtk3-devel, gtk3
%endif

Provides: signal-desktop
Summary: Signal Private Messenger for the Desktop
Release: 1%{?dist}
License: GPL3
BuildRoot: %{buildroot}

%files
%dir /usr/lib/%{pkgname}/
/usr/share/icons/hicolor/16x16/apps/%{pkgname}.png
/usr/share/icons/hicolor/24x24/apps/%{pkgname}.png
/usr/share/icons/hicolor/32x32/apps/%{pkgname}.png
/usr/share/icons/hicolor/48x48/apps/%{pkgname}.png
/usr/share/icons/hicolor/64x64/apps/%{pkgname}.png
/usr/share/icons/hicolor/128x128/apps/%{pkgname}.png
/usr/share/icons/hicolor/256x256/apps/%{pkgname}.png
/usr/share/icons/hicolor/512x512/apps/%{pkgname}.png
/usr/bin/%{pkgname}-desktop
/usr/share/applications/%{pkgname}.desktop
/usr/share/applications/%{pkgname}-tray.desktop
/usr/lib/signal/resources/app.asar
/usr/lib/signal/resources/app.asar.unpacked/node_modules/spellchecker/vendor/hunspell_dictionaries/README.txt
/usr/lib/signal/resources/app.asar.unpacked/node_modules/spellchecker/vendor/hunspell_dictionaries/en_US.aff
/usr/lib/signal/resources/app.asar.unpacked/node_modules/spellchecker/vendor/hunspell_dictionaries/en_US.dic
/usr/lib/signal/resources/electron.asar

%description
Signal Private Messenger for the Desktop


%prep
mkdir %{name}-%{version}
tar -xzf "%{_sourcedir}/%{name}-%{version}.tar.gz" --strip 1 -C "%{name}-%{version}"
chmod -R a+rX,g-w,o-w .


%clean
if [ %{_builddir} == "/" ] || [ %{_builddir} == "$HOME" ]
then
    echo "Ignoring cleanup command on / (root) directory..."
    exit 1
else
    rm -rv %{_builddir}/*
fi

if [ %{buildroot} == "/" ] || [ %{buildroot} == "$HOME" ]
then
    echo "Ignoring cleanup command on / (root) directory..."
    exit 1
else
    rm -rv %{buildroot}/*
fi


%build
mkdir -p %{buildroot}
mkdir -p %{buildroot}/usr/bin
cd %{_builddir}/%{name}-%{version}
_npm_prefix=$(npm config get prefix)
npm config delete prefix

yarn install
yarn generate
yarn build-release --dir

npm config set prefix ${_npm_prefix}


%install
cd %{_builddir}/%{name}-%{version}
install -dm755 "%{buildroot}/usr/lib/%{pkgname}"
cp -r "release/linux-unpacked/resources" "%{buildroot}/usr/lib/%{pkgname}/"

install -dm755 %{buildroot}/usr/share/icons/hicolor
for i in 16 24 32 48 64 128 256 512; do
    install -Dm644 build/icons/png/${i}* %{buildroot}/usr/share/icons/hicolor/${i}x${i}/apps/%{pkgname}.png
done

install -dm755 %{buildroot}/usr/bin
install -Dm755 %{_sourcedir}/pkg/%{pkgname}.sh %{buildroot}/usr/bin/%{pkgname}-desktop
install -Dm644 %{_sourcedir}/pkg/%{pkgname}.desktop %{buildroot}/usr/share/applications/%{pkgname}.desktop
install -Dm644 %{_sourcedir}/pkg/%{pkgname}-tray.desktop %{buildroot}/usr/share/applications/%{pkgname}-tray.desktop
