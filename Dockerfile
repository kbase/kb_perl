FROM kbase/kb_perl:frozen
# Container designed to run kbase perl apps using Starman. Due to the fragility
# of the perl dependencies, this image is built using the last image known to
# build semi-cleanly, the kbase/kb_perl:frozen image. That is already a running
# environment for perl, this dockerfile is meant for additional overlays until
# such time as handle_service and handle_mngr can be rewritten entirely in
# python

# These ARGs values are passed in via the docker build command
ARG BUILD_DATE
ARG VCS_REF
ARG BRANCH=develop

COPY dockerize /kb/deployment/bin

# The BUILD_DATE value seem to bust the docker cache when the timestamp changes, move to
# the end
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/kbase/kb_perl.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1" \
      us.kbase.vcs-branch=$BRANCH \
      maintainer="Steve Chan sychan@lbl.gov"
      
