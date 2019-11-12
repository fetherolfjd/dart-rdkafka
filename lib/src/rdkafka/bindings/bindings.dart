import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'signatures.dart';

import '../../common/utils.dart';

class _RdKafkaBindings {

  DynamicLibrary rdKafka;

  int Function() rd_kafka_version;
  Pointer<Utf8> Function() rd_kafka_version_str;
  Pointer<Utf8> Function() rd_kafka_get_debug_contexts;

  _RdKafkaBindings() {
    rdKafka = openLibraryForPlatform('rdkafka');

    rd_kafka_version = rdKafka
      .lookup<NativeFunction<rd_kafka_version_native_t>>('rd_kafka_version')
      .asFunction();

    rd_kafka_version_str = rdKafka
      .lookup<NativeFunction<rd_kafka_version_str_native_t>>('rd_kafka_version_str')
      .asFunction();

    rd_kafka_get_debug_contexts = rdKafka
      .lookup<NativeFunction<rd_kafka_get_debug_contexts_native_t>>('rd_kafka_get_debug_contexts')
      .asFunction();

  }

}

_RdKafkaBindings _rdKafkaBindings;

_RdKafkaBindings get bindings => _rdKafkaBindings ??= _RdKafkaBindings();
