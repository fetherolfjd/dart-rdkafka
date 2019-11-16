#!/bin/sh
set -ev
sudo apt-get install -y gcc g++ make
git clone https://github.com/edenhill/librdkafka.git
cd librdkafka && ./configure --install-deps && make && make install
