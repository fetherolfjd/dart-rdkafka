import 'dart:ffi';

import 'package:ffi/ffi.dart';

// class CString extends Pointer<Uint8> {}

typedef rd_kafka_version_str = Pointer<Utf8> Function();
typedef RdkafkaVersionStr = Pointer<Utf8> Function();

class Awesome {

  void doStuff() {
    var path = '/usr/local/lib/librdkafka.so';
    final dylib = DynamicLibrary.open(path);

    final rdkafkaVersionStrPtr = dylib.lookup<NativeFunction<rd_kafka_version_str>>('rd_kafka_version_str');
    final rdkafkaVersionStr = rdkafkaVersionStrPtr.asFunction<RdkafkaVersionStr>();
    final kafkaVersion = rdkafkaVersionStr();

    print('rdkafka version: ${Utf8.fromUtf8(kafkaVersion)}');
  }

}
