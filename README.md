# Signal-Desktop RPM

Build an `rpm` package for [Signal-Desktop](https://github.com/signalapp/Signal-Desktop) to install Signal on Fedora.


## How to build the RPM?

1. Clone the repo && `cd` into it.
2. Execute `make clean && make dependencies && make build`
3. Install the freshly built `rpm` package with `dnf`: `dnf install ./RPMS/x86_64/Signal-Desktop-1.11.0-1.x86_64.rpm`
4. To use Signal, invoke: `signal-desktop` from the commandline.


## New Signal Version?

If my current Signal copy is outdated you should be able to execute
`./update.sh` and rebuild the `rpm` package.


## What about CentOS?

Currently it doesn't work with CentOS due to version mismatches of npm and nodejs.
Feel free to submit a PR which solves that issue.


## Why does this even exist?

The official Repository for Signal doesn't yet contain an official `rpm` for Fedora/RHEL users.
Furthermore I never built an `rpm` by myself, so I thought that would make a good learning project.


## Credits / References

+ [signalapp/Signal-Desktop](https://github.com/signalapp/Signal-Desktop)
+ [AUR Signal package @dbirks (Jake)](https://aur.archlinux.org/packages/signal/)
+ [Fedora docs: Creating RPM packages](https://docs.fedoraproject.org/quick-docs/en-US/creating-rpm-packages.html)
