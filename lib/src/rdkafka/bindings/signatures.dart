import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'types.dart';

typedef rd_kafka_version_native_t = Int32 Function();

typedef rd_kafka_version_str_native_t = Pointer<Utf8> Function();

typedef rd_kafka_get_debug_contexts_native_t = Pointer<Utf8> Function();

typedef rd_kafka_get_err_descs_native_t = Void Function(Pointer<Pointer<RdKafkaErrDesc>> errdescs, Pointer<Int32> cntp);

typedef rd_kafka_err2str_native_t = Pointer<Utf8> Function(Int32 err);

typedef rd_kafka_err2name_native_t = Pointer<Utf8> Function(Int32 err);

typedef rd_kafka_last_error_native_t = Int32 Function();
