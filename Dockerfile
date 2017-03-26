FROM centos:7
MAINTAINER vEyE Security <info@veye-security.com>

ADD suite-definition.xml /var/lib/phoronix-test-suite/test-suites/local/container/suite-definition.xml
RUN yum install -y epel-release && \
    yum install -y phoronix-test-suite bzip2 unzip bc && \
    phoronix-test-suite batch-install local/container && \
    yum clean all

RUN printf "n\nn\n" | phoronix-test-suite batch-setup

RUN phoronix-test-suite user-config-set StandardDeviationThreshold=1.0

ENV FORCE_TIMES_TO_RUN=10
CMD phoronix-test-suite batch-run local/container
