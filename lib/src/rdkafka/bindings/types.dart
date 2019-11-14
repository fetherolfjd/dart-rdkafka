import 'dart:ffi';

import 'package:ffi/ffi.dart';

class RdKafkaErrDesc extends Struct {
  @Int32()
  int code;

  Pointer<Utf8> name;

  Pointer<Utf8> desc;
}
