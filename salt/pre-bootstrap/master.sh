#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq

# pygit2 deps
LIBGIT_VERSION="0.20.0"
apt-get install -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" python-pip python-dev cmake unzip pkg-config libssh2-1-dev libssl-dev
cd /usr/local/src/
wget -q https://github.com/libgit2/libgit2/archive/v${LIBGIT_VERSION}.zip -O libgit2.zip
unzip libgit2.zip && rm libgit2.zip
mv libgit2-$LIBGIT_VERSION libgit2
cd libgit2
mkdir build && cd build
cmake ..
cmake --build .
cmake --build . --target install
ldconfig
apt-get install -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" python-cffi libffi-dev
pip -q install -U 'pygit2 == 0.20.3'
