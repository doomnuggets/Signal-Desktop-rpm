build:
	mkdir $(PWD)/{SOURCES,BUILD,RPMS,BUILDROOT} 2>/dev/null || true
	RPM_BUILD_ROOT=$(PWD)/BUILDROOT rpmbuild -bb SPECS/signal.spec --define "_sourcedir $(PWD)/SOURCES" --define "_builddir $(PWD)/BUILD" --define "_rpmdir $(PWD)/RPMS" --define "buildroot $(PWD)/BUILDROOT"

dependencies:
	bash ./install_deps.sh

clean:
	rm -rf $(PWD)/BUILD/*
	rm -rf $(PWD)/BUILDROOT/*
	rm -rf $(PWD)/RPMS/*
