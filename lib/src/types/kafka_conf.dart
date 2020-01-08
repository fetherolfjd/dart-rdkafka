import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'package:dart_rdkafka/src/rdkafka/bindings/bindings.dart';
import 'package:dart_rdkafka/src/rdkafka/bindings/types.dart';

class KafkaConf {
  Pointer<RdKafkaConf> _rdKafkaConf;
  Map<String, String> configs;

  KafkaConf() {
    if (_rdKafkaConf == null) {
      _rdKafkaConf = bindings.rd_kafka_conf_new();
    }
  }

  void dump() {
    Pointer<IntPtr> cntp = allocate();
    Pointer<Pointer<Utf8>> props =
        bindings.rd_kafka_conf_dump(_rdKafkaConf, cntp);
    for (int i = 0; i < cntp.value; ++i) {
      Pointer<Utf8> prop = props.elementAt(i).value;
      String propString = Utf8.fromUtf8(prop);
      print(propString);
    }
    free(cntp);
  }
}
