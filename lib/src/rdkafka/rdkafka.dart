import 'package:ffi/ffi.dart';

import 'bindings/bindings.dart';

class RdKafka {

  int rdKafkaVersion() {
    return bindings.rd_kafka_version();
  }

  String rdKafkaVersionStr() {
    return Utf8.fromUtf8(bindings.rd_kafka_version_str());
  }

  String rdKafkaGetDebugContexts() {
    return Utf8.fromUtf8(bindings.rd_kafka_get_debug_contexts());
  }

}
