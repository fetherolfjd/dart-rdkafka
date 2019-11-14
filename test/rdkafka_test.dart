import 'package:dart_rdkafka/dart_rdkafka.dart';
import 'package:dart_rdkafka/src/rdkafka/rdkafka.dart';
import 'package:test/test.dart';

void main() {
  RdKafka rdKafka;

  setUp(() {
    rdKafka = RdKafka();
  });

  group('Test int version', () {
    test('Test rdkafka is expected version', () {
      final expected = '10202ff';
      final version = rdKafka.rdKafkaVersion();
      expect(version.toRadixString(16), equals(expected));
    });
  });

  group('Test string version', () {
    test('Test rdkafka is expected version', () {
      final expected = '1.2.2-RC1-1-g8d44dd';
      final version = rdKafka.rdKafkaVersionStr();
      expect(version, equals(expected));
    });
  });

  group('Test debug contexts', () {
    test('Test expected debug contexts exist', () {
      final expected = 'all,generic,broker,topic,metadata,feature,queue,msg,protocol,cgrp,security,fetch,interceptor,plugin,consumer,admin,eos';
      final contexts = rdKafka.rdKafkaGetDebugContexts();
      expect(contexts, equals(expected));
    });
  });

  group('Test error descriptions', () {
    test('Test error descriptions are returned', () {
      List<RdKafkaErrDesc> errDescs = rdKafka.rdKafkaGetErrDescs();
      expect(errDescs, isNotNull);
      expect(errDescs, isNotEmpty);
      expect(errDescs.length, equals(136));
    });
  });
}
