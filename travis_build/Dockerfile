FROM google/dart:2.6

ARG LIBRDKAFKA_VERSION

WORKDIR /usr/src
RUN apt-get update && \
apt-get install -y \
gcc \
g++ \
make \
&& \
git clone https://github.com/edenhill/librdkafka.git && \
cd librdkafka && \
git checkout ${LIBRDKAFKA_VERSION} && \
./configure --install-deps && \
make && \
make install && \
mkdir -p /app

RUN mkdir -p /app
COPY . /app
WORKDIR /app
RUN pub get

CMD pub run test
