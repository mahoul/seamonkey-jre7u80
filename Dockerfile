FROM ubuntu:xenial

MAINTAINER Enrique Gil <mahoul@gmail.com>

COPY dist/jre-7u80-linux-x64.tar.gz /jre-7u80-linux-x64.tar.gz
COPY dist/root-config.tar.gz /root-config.tar.gz

# Install seamonkey and deps
RUN apt-get update && \
apt-get install -y apt-transport-https && \
echo \
'deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main' \
> /etc/apt/sources.list.d/seamonkey.list && \
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2667CA5C && \
apt-get update && \
apt-get install -y seamonkey-mozilla-build \
 vim \
 desktop-file-utils \
 libfreetype6 \
 libgtk-3-0 \
 libfontconfig1 \
 libxrender1 \
 libxext6 \
 libxdamage1 \
 libxfixes3 \
 libxcomposite1 \
 libasound2 \
 libdbus-glib-1-2 \
 libgtk2.0-0 \
 libxt6 \
 libxtst6 \
 rsync && \
mkdir -p /usr/lib/jvm/ && \
mkdir -p /usr/lib/mozilla/plugins/ && \
tar -C /usr/lib/jvm/ -xzf /jre-7u80-linux-x64.tar.gz && \
tar -C /root -xzf /root-config.tar.gz && \
ln -sf /usr/lib/jvm/jre1.7.0_80 /usr/lib/jvm/latest && \
update-alternatives \
 --install /usr/bin/java java \
 /usr/lib/jvm/latest/bin/java 200000 && \
update-alternatives \
 --install /usr/bin/javaws javaws \ 
 /usr/lib/jvm/latest/bin/javaws 200000 && \
update-alternatives \
 --install /usr/lib/mozilla/plugins/libjavaplugin.so mozilla-javaplugin.so \
 /usr/lib/jvm/latest/lib/amd64/libnpjp2.so 200000 && \
rsync -avP /usr/lib/jvm/latest/lib/desktop/mime/packages/ /usr/share/mime/packages/ && \
rsync -avP /usr/lib/jvm/latest/lib/desktop/applications/ /usr/share/applications/ && \
rsync -avP /usr/lib/jvm/latest/lib/desktop/icons/ /usr/share/icons/ && \
update-mime-database -V /usr/share/mime/ && \
update-desktop-database -v && \
update-icon-caches /usr/share/icons/ && \
rm -f /jre-7u80-linux-x64.tar.gz /root-config.tar.gz && \
apt-get autoremove -y && \
apt-get clean

CMD /usr/bin/seamonkey

WORKDIR /root

