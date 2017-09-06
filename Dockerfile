FROM bitnami/minideb:stretch
MAINTAINER Steve Chan sychan@lbl.gov

# Container designed to run kbase perl apps using Starman

# These ARGs values are passed in via the docker build command
ARG BUILD_DATE
ARG VCS_REF
ARG BRANCH=develop

# Shinto-cli is a jinja2 template cmd line tool
# Install perl dependencies. Force Moose and RPC::Any::Server::JSONRPC::PSGI installation
# as the perl interpreter updates have broken the library unit tests
RUN apt-get update -y && apt-get install -y apt-utils && \
    apt-get install -y ca-certificates cpanminus python-minimal python-pip openssl wget \
            libhttp-parser-xs-perl && \
    update-ca-certificates && \
    pip install shinto-cli[yaml] && \
    cpanm HTTP::Request LWP::UserAgent JSON Exception::Class Config::Simple Object::Tiny::RW \
          Starman Plack::Handler::Starman Plack::Middleware::CrossOrigin JSON::RPC::Client \
          inc::Module::Install Class::Accessor && \
    cpanm -f http://search.cpan.org/CPAN/authors/id/D/DO/DOY/Moose-2.0604.tar.gz && \
    cpanm -f RPC::Any::Server::JSONRPC::PSGI

# Setup the base perl libs
CMD mkdir -p /kb/deployment/lib
ENV PERL5LIB /kb/deployment/lib
COPY deployment /kb/deployment

# The BUILD_DATE value seem to bust the docker cache when the timestamp changes, move to
# the end
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/kbase/kb_perl.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1" \
      us.kbase.vcs-branch=$BRANCH
