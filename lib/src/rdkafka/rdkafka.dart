import 'dart:ffi';

import 'package:dart_rdkafka/src/types/kafka_conf.dart';
import 'package:ffi/ffi.dart';

import 'bindings/bindings.dart';
import '../types/rd_kafka_err_desc.dart';
import 'bindings/types.dart' as types;

class RdKafka {
  List<RdKafkaErrDesc> _errDescsCache;
  Pointer<types.RdKafkaConf> _confCache;

  int rdKafkaVersion() {
    return bindings.rd_kafka_version();
  }

  String rdKafkaVersionStr() {
    Pointer<Utf8> versionCStr = bindings.rd_kafka_version_str();
    String version = Utf8.fromUtf8(versionCStr);
    free(versionCStr);
    return version;
  }

  String rdKafkaGetDebugContexts() {
    return Utf8.fromUtf8(bindings.rd_kafka_get_debug_contexts());
  }

  List<RdKafkaErrDesc> rdKafkaGetErrDescs() {
    if (_errDescsCache == null) {
      _errDescsCache = [];
      Pointer<Pointer<types.RdKafkaErrDesc>> errDescs = allocate();
      Pointer<Int32> cnts = allocate();
      bindings.rd_kafka_get_err_descs(errDescs, cnts);
      for (int i = 0; i < cnts.value; ++i) {
        Pointer<types.RdKafkaErrDesc> errDescPtr = errDescs.value.elementAt(i);
        if (errDescPtr.ref.name.address != 0x0 &&
            errDescPtr.ref.desc.address != 0x0) {
          final RdKafkaErrDesc ed = RdKafkaErrDesc();
          ed.code = errDescPtr.ref.code;
          ed.name = Utf8.fromUtf8(errDescPtr.ref.name);
          ed.desc = Utf8.fromUtf8(errDescPtr.ref.name);
          _errDescsCache.add(ed);
        }
      }
      free(errDescs);
      free(cnts);
    }
    return _errDescsCache;
  }

  String rdKafkaErrorToString(int err) {
    return Utf8.fromUtf8(bindings.rd_kafka_err2str(err));
  }

  String rdKafkaErrorToName(int err) {
    return Utf8.fromUtf8(bindings.rd_kafka_err2name(err));
  }

  int rdKafkaLastError() {
    return bindings.rd_kafka_last_error();
  }

  void rdKafkaConfNew() {
    // need to cache the kafka conf object, only getting a new one if we've somehow
    // lost or not created one yet. provide interface to set and get configuration
    if (_confCache == null) {
      _confCache = bindings.rd_kafka_conf_new();
    }

    Pointer<types.RdKafkaConf> conf = bindings.rd_kafka_conf_new();
    print(conf.ref);
    Pointer<IntPtr> cntp = allocate();
    Pointer<Pointer<Utf8>> props = bindings.rd_kafka_conf_dump(conf, cntp);
    for (int i = 0; i < cntp.value; ++i) {
      Pointer<Utf8> prop = props.elementAt(i).value;
      String propString = Utf8.fromUtf8(prop);
      print(propString);
    }

    Map<String, dynamic> kafkaConfigs = {};
  }

  // void rdKafkaConfDestroy() {}

  void rdKafkaConfDump(Pointer<types.RdKafkaConf> conf) {
    Pointer<IntPtr> cntp = allocate();
    Pointer<Pointer<Utf8>> props = bindings.rd_kafka_conf_dump(conf, cntp);
    for (int i = 0; i < cntp.value; ++i) {
      Pointer<Utf8> prop = props.elementAt(i).value;
      String propString = Utf8.fromUtf8(prop);
      print(propString);
    }
    free(cntp);
  }

  // void rdKafkaConfDumpFree() {}
}
