FROM centos:latest
MAINTAINER Yuri Shapira <yuri@veye-security.com>
ADD https://api.github.com/repos/phoronix-test-suite/phoronix-test-suite/git/refs/tags tags.json
RUN yum install -y git php-cli php-xml php-pdo which xdg-utils; \
    git clone https://github.com/phoronix-test-suite/phoronix-test-suite.git; \
    cd phoronix-test-suite/; \
    latesttag=$(git tag|sed '$!d'); \
    echo checking out ${latesttag}; \
    git checkout ${latesttag}; \
    bash install-sh; \
    cd .. ; \
    rm -rf phoronix-test-suite; \
    phoronix-test-suite batch-install pts/workstation; \
    yum autoremove -y git; \
    yum clean all
ENTRYPOINT ["phoronix-test-suite", "default-run", "pts/workstation"]