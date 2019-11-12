import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef rd_kafka_version_native_t = Int32 Function();

typedef rd_kafka_version_str_native_t = Pointer<Utf8> Function();

typedef rd_kafka_get_debug_contexts_native_t = Pointer<Utf8> Function();
