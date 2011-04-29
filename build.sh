#!/usr/bin/env bash

# Clean the workspace
[ -s ./Build ] && ./Build realclean || echo Clean.

if [ -x `which cpanm` ]; then
   cpanm -v Archive::Tar
   # Create Build and run tests
   perl ./Build.PL &&
   (
      ./Build manifest &&
      ./Build prereq_report &&
      ./Build installdeps --cpan_client 'cpanm -vi' &&
      ./Build &&
      ./Build test
   ) &&
   ./Build disttest &&
   ./Build distcheck &&
   ./Build dist &&
   ./Build fakeinstall
fi
