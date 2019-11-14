import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'signatures.dart';
import 'types.dart';
import '../../common/utils.dart';

class _RdKafkaBindings {

  DynamicLibrary rdKafka;

  int Function() rd_kafka_version;
  Pointer<Utf8> Function() rd_kafka_version_str;
  Pointer<Utf8> Function() rd_kafka_get_debug_contexts;
  void Function(Pointer<Pointer<RdKafkaErrDesc>> errdescs, Pointer<Int32> cntp) rd_kafka_get_err_descs;

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

    rd_kafka_get_err_descs = rdKafka
      .lookup<NativeFunction<rd_kafka_get_err_descs_native_t>>('rd_kafka_get_err_descs')
      .asFunction();

  }

}

_RdKafkaBindings _rdKafkaBindings;

_RdKafkaBindings get bindings => _rdKafkaBindings ??= _RdKafkaBindings();
