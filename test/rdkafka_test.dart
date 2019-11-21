import 'package:dart_rdkafka/dart_rdkafka.dart';
import 'package:dart_rdkafka/src/rdkafka/rdkafka.dart';
import 'package:test/test.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time} - ${rec.message}');
  });

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
      final expected = '1.2.2';
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

  group('Test err to string', () {
    test('Test error strings match', () {
      List<RdKafkaErrDesc> errDescs = rdKafka.rdKafkaGetErrDescs();
      errDescs.forEach((ed) {
        final err = rdKafka.rdKafkaErrorToString(ed.code);
        expect(err, isNotNull);
        expect(err, isNotEmpty);
      });
    });
  });

  group('Test err to name', () {
    test('Test error names match', () {
      List<RdKafkaErrDesc> errDescs = rdKafka.rdKafkaGetErrDescs();
      errDescs.forEach((ed) {
        final err = rdKafka.rdKafkaErrorToName(ed.code);
        expect(err, equals(ed.name));
      });
    });
  });

  group('Test last error', () {
    test('Last error is zero', () {
      final lastErr = rdKafka.rdKafkaLastError();
      expect(lastErr, equals(0));
    });
  });
}
