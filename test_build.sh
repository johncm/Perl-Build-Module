#!/usr/bin/env bash

source ../Build-Module/build.sh

export PERL_CPANM_HOME=${PERL_CPANM_HOME:-${WORKSPACE}}
OPT=--local-lib=${PERL_CPANM_HOME}
export PERL_CPANM_OPT=${PERL_CPANM_OPT:-${OPT}}

export PATH=${PERL_CPANM_HOME}/bin:${PATH}
export PERL5LIB=${PERL5LIB:-${PERL_CPANM_HOME}/lib/perl5}

if [ -x `which cpanm` ]; then
   cpanm -v --notest TAP::Formatter::JUnit
   # Make sure to setup the "Publish JUnit test result report" with output location
   prove -I${PERL5LIB} --blib --timer --formatter=TAP::Formatter::JUnit > \
         ../prove_output.xml &&
   cpanm -v PJCJ/Devel-Cover-0.73.tar.gz
   # Make sure to setup the "Publish HTML reports" to cover_db
   ./Build testcover
   ./Build html
fi
