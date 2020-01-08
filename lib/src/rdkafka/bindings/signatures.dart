import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'types.dart';

typedef rd_kafka_version_native_t = Int32 Function();

typedef rd_kafka_version_str_native_t = Pointer<Utf8> Function();

typedef rd_kafka_get_debug_contexts_native_t = Pointer<Utf8> Function();

typedef rd_kafka_get_err_descs_native_t = Void Function(
    Pointer<Pointer<RdKafkaErrDesc>> errdescs, Pointer<Int32> cntp);

typedef rd_kafka_err2str_native_t = Pointer<Utf8> Function(Int32 err);

typedef rd_kafka_err2name_native_t = Pointer<Utf8> Function(Int32 err);

typedef rd_kafka_last_error_native_t = Int32 Function();

typedef rd_kafka_conf_new_native_t = Pointer<RdKafkaConf> Function();

typedef rd_kafka_conf_destroy_native_t = Void Function(
    Pointer<RdKafkaConf> conf);

typedef rd_kafka_conf_dump_native_t = Pointer<Pointer<Utf8>> Function(
    Pointer<RdKafkaConf> conf, Pointer<IntPtr> cntp);

typedef rd_kafka_conf_dump_free_native_t = Void Function(
    Pointer<Pointer<Utf8>> arr, Uint64 cnt);

// errstr_size is of type "size_t", so it seems the best thing to do is use IntPtr according to some Googling...
// typedef rd_kafka_fatal_error_native_t = Int32 Function(Pointer<RdKafkaClientHandle> rk, Pointer<Utf8> errstr, IntPtr errstr_size);

// typedef rd_kafka_new_native_t = Pointer<RdKafkaClientHandle> Funtion(Int32 type, )
