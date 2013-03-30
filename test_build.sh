#!/usr/bin/env bash

source ../Build-Module/build.sh

export PERL_CPANM_HOME=${PERL_CPANM_HOME:-${WORKSPACE}/cpanlib}
OPT=--local-lib=${PERL_CPANM_HOME}
export PERL_CPANM_OPT=${PERL_CPANM_OPT:-${OPT}}

export PATH=${PERL_CPANM_HOME}/bin:${PATH}
export PERL5LIB=${PERL5LIB:-${PERL_CPANM_HOME}/lib/perl5}

if [ -x `which cpanm` ]; then
   # Make sure to setup the "Publish JUnit test result report" with output location
   cpanm -v --notest TAP::Formatter::JUnit &&
   prove -I${PERL5LIB} --blib --timer --formatter=TAP::Formatter::JUnit > \
         ${WORKSPACE}/prove_output.xml &&
   cpanm -v PJCJ/Devel-Cover-0.73.tar.gz &&
   ./Build testcover
   # Make sure to setup the "Publish HTML reports" to cover_db
fi
./Build html
