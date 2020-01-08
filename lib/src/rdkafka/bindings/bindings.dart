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
  void Function(Pointer<Pointer<RdKafkaErrDesc>> errdescs, Pointer<Int32> cntp)
      rd_kafka_get_err_descs;
  Pointer<Utf8> Function(int err) rd_kafka_err2str;
  Pointer<Utf8> Function(int err) rd_kafka_err2name;
  int Function() rd_kafka_last_error;
  // int Function(Pointer<RdKafkaClientHandle> rk, Pointer<Utf8> errstr, int errstr_size) rd_kafka_fatal_error;
  Pointer<RdKafkaConf> Function() rd_kafka_conf_new;
  void Function(Pointer<RdKafkaConf> conf) rd_kafka_conf_destroy;
  Pointer<Pointer<Utf8>> Function(
      Pointer<RdKafkaConf> conf, Pointer<IntPtr> cntp) rd_kafka_conf_dump;
  void Function(Pointer<Pointer<Utf8>> arr, int cnt) rd_kafka_conf_dump_free;

  _RdKafkaBindings() {
    rdKafka = Loader.openLibrary('rdkafka');

    rd_kafka_version = rdKafka
        .lookup<NativeFunction<rd_kafka_version_native_t>>('rd_kafka_version')
        .asFunction();

    rd_kafka_version_str = rdKafka
        .lookup<NativeFunction<rd_kafka_version_str_native_t>>(
            'rd_kafka_version_str')
        .asFunction();

    rd_kafka_get_debug_contexts = rdKafka
        .lookup<NativeFunction<rd_kafka_get_debug_contexts_native_t>>(
            'rd_kafka_get_debug_contexts')
        .asFunction();

    rd_kafka_get_err_descs = rdKafka
        .lookup<NativeFunction<rd_kafka_get_err_descs_native_t>>(
            'rd_kafka_get_err_descs')
        .asFunction();

    rd_kafka_err2str = rdKafka
        .lookup<NativeFunction<rd_kafka_err2str_native_t>>('rd_kafka_err2str')
        .asFunction();

    rd_kafka_err2name = rdKafka
        .lookup<NativeFunction<rd_kafka_err2name_native_t>>('rd_kafka_err2name')
        .asFunction();

    rd_kafka_last_error = rdKafka
        .lookup<NativeFunction<rd_kafka_last_error_native_t>>(
            'rd_kafka_last_error')
        .asFunction();

    // rd_kafka_fatal_error = rdKafka
    //   .lookup<NativeFunction<rd_kafka_fatal_error_native_t>>('rd_kafka_fatal_error')
    //   .asFunction();

    rd_kafka_conf_new = rdKafka
        .lookup<NativeFunction<rd_kafka_conf_new_native_t>>('rd_kafka_conf_new')
        .asFunction();

    rd_kafka_conf_destroy = rdKafka
        .lookup<NativeFunction<rd_kafka_conf_destroy_native_t>>(
            'rd_kafka_conf_destroy')
        .asFunction();

    rd_kafka_conf_dump_free = rdKafka
        .lookup<NativeFunction<rd_kafka_conf_dump_free_native_t>>(
            'rd_kafka_conf_dump_free')
        .asFunction();

    rd_kafka_conf_dump = rdKafka
        .lookup<NativeFunction<rd_kafka_conf_dump_native_t>>(
            'rd_kafka_conf_dump')
        .asFunction();
  }
}

_RdKafkaBindings _rdKafkaBindings;

_RdKafkaBindings get bindings => _rdKafkaBindings ??= _RdKafkaBindings();
