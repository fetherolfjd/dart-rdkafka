# dart-rdkafka  [![Build Status](https://travis-ci.org/fetherolfjd/dart-rdkafka.svg?branch=master)](https://travis-ci.org/fetherolfjd/dart-rdkafka)
# Dart wrapper of the Apache Kafka C/C++ client library

## Overview

The `dart-rdkafka` library uses the foreign function interface library from Dart
to wrap and call into the C [librdkafka](https://github.com/edenhill/librdkafka).

## Use

This library assumes that you have the C library `librdkafka.so` installed on your system.

## Other Information

The intent of this package is to be as  direct a wrapping of the API provided by
[`rdkafka.h`](https://github.com/edenhill/librdkafka/blob/master/src/rdkafka.h) in
[librdkafka](https://github.com/edenhill/librdkafka) as is practical. As such it
will provide a pretty low-level interaction with Apache Kafka. Hopefully in the
future other Dart packages can provide higher level abstractions on top of this.
