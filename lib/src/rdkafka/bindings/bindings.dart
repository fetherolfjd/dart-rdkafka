import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:logging/logging.dart';

import 'signatures.dart';
import 'types.dart';
import '../../common/utils.dart';

class _RdKafkaBindings {
  final Logger log = Logger('_RdKafkaBindings');

  DynamicLibrary rdKafka;

  int Function() rd_kafka_version;
  Pointer<Utf8> Function() rd_kafka_version_str;
  Pointer<Utf8> Function() rd_kafka_get_debug_contexts;
  void Function(Pointer<Pointer<RdKafkaErrDesc>> errdescs, Pointer<Int32> cntp) rd_kafka_get_err_descs;
  Pointer<Utf8> Function(int err) rd_kafka_err2str;
  Pointer<Utf8> Function(int err) rd_kafka_err2name;

  _RdKafkaBindings() {
    rdKafka = Loader.openLibrary('rdkafka');

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

    rd_kafka_err2str = rdKafka
      .lookup<NativeFunction<rd_kafka_err2str_native_t>>('rd_kafka_err2str')
      .asFunction();

    rd_kafka_err2name = rdKafka
      .lookup<NativeFunction<rd_kafka_err2name_native_t>>('rd_kafka_err2name')
      .asFunction();

  }

}

_RdKafkaBindings _rdKafkaBindings;

_RdKafkaBindings get bindings => _rdKafkaBindings ??= _RdKafkaBindings();
