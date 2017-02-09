FROM centos:latest
MAINTAINER Yuri Shapira <yuri@veye-security.com>
ADD https://api.github.com/repos/phoronix-test-suite/phoronix-test-suite/git/refs/tags tags.json
RUN yum install -y git php-cli php-xml php-pdo which; \
    git clone https://github.com/phoronix-test-suite/phoronix-test-suite.git; \
    cd phoronix-test-suite/; \
    latesttag=$(git tag|sed '$!d'); \
    echo checking out ${latesttag}; \
    git checkout ${latesttag}; \
    bash install-sh; \
    cd .. ; \
    rm -rf phoronix-test-suite; \
    yum autoremove -y git; \
    yum clean all
RUN phoronix-test-suite user-config-set RemoteAccessPort=80; \
    printf "rootadmin\n" | phoronix-test-suite phoromatic.set-root-admin-password
ADD phoromatic.db /var/lib/phoronix-test-suite/phoromatic/phoromatic.db
ENTRYPOINT ["phoronix-test-suite"]