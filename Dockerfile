FROM raspberrypython/base:latest
MAINTAINER David Noyes <david@raspberrypython.com>

RUN add-apt-repository -y  ppa:jcfp/ppa && \
    apt-get -q update && \
    apt-get install -qy --force-yes sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush \
    par2 python-yenc unzip unrar && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN groupadd --gid 1001 media && \
    useradd --no-create-home --uid 1001 --gid 1001 media

VOLUME ["/config","/data","/Videos"]

EXPOSE 8080

USER media

CMD ["/usr/bin/sabnzbdplus","--config-file","/config","--console","--server", "0.0.0.0:8080"]
