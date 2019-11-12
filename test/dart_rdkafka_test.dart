import 'package:dart_rdkafka/src/rdkafka/rdkafka.dart';
import 'package:test/test.dart';

void main() {
  group('A simple group of tests', () {
    RdKafka rdKafka;

    setUp(() {
      rdKafka = RdKafka();
    });

    test('First Simple Test', () {
      print('Got int version: ${rdKafka.rdKafkaVersion()}');
      print('Got str version: ${rdKafka.rdKafkaVersionStr()}');
      print('Got debug ctx: ${rdKafka.rdKafkaGetDebugContexts()}');
    });
  });
}
