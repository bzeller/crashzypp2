FROM opensuse/tumbleweed
MAINTAINER Jimmy Berry <jberry@suse.com>
LABEL akjsdhfiuv1zb8o07v2398u1=oihonpqbiuve

ADD valgrind-3.14.0-4.2.x86_64.rpm /
RUN rpm -i /valgrind-3.14.0-4.2.x86_64.rpm
RUN uname -a

RUN zypper -nv in libzypp || :
RUN rm -rf /tmp/* /var/tmp/* /var/cache/* /var/log/*
RUN valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f

RUN zypper -nv in glibc || :
RUN rm -rf /tmp/* /var/tmp/* /var/cache/* /var/log/*
#RUN valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f
RUN bash -c "ZYPP_LOGFILE=/tmp/zypplog valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f || cat /tmp/zypplog"

RUN zypper -nv in libcurl4 || :
RUN rm -rf /tmp/* /var/tmp/* /var/cache/* /var/log/*
#RUN valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f
RUN bash -c "ZYPP_LOGFILE=/tmp/zypplog valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f || cat /tmp/zypplog"

RUN zypper -nv in zypper || :
RUN rm -rf /tmp/* /var/tmp/* /var/cache/* /var/log/*
RUN bash -c "ZYPP_LOGFILE=/tmp/zypplog valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f || cat /tmp/zypplog"
