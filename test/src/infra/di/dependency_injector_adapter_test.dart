import 'dart:async';

import 'package:alligator/alligator.dart';
import 'package:test/test.dart';

class TestClass {
  final String data;
  TestClass(this.data);
}

void main() {
  group('DependencyInjector', () {
    test('register and get instance', () {
      final di = Alligator();
      di.register<TestClass>(() => TestClass('Hello, Alligator!'),
          isSingleton: false);

      final instance = di.get<TestClass>();
      expect(instance, isA<TestClass>());
      expect(instance.data, 'Hello, Alligator!');
    });

    test('register and get singleton', () {
      final di = Alligator();
      di.register<TestClass>(() => TestClass('Hello, Alligator!'),
          isSingleton: true);

      final instance1 = di.get<TestClass>();
      final instance2 = di.get<TestClass>();
      expect(identical(instance1, instance2), isTrue);
    });

    test('register and get non-singleton', () {
      final di = Alligator();
      di.register<TestClass>(() => TestClass('Hello, Alligator!'),
          isSingleton: false);

      final instance1 = di.get<TestClass>();
      final instance2 = di.get<TestClass>();
      expect(identical(instance1, instance2), isFalse);
    });

    test('get unregistered instance', () {
      final di = Alligator();
      bool exceptionThrown = false;

      runZonedGuarded(() {
        di.get<TestClass>();
      }, (error, stackTrace) {
        exceptionThrown = error is Exception &&
            error.toString() ==
                'Exception: [Exception] Instance TestClass not found';
      });

      expect(exceptionThrown, isTrue);
    });
  });

  group('InstanceGenerator', () {
    test('create singleton instance', () {
      final generator = InstanceGenerator<TestClass>(
          () => TestClass('Hello, Alligator!'), true);

      final instance1 = generator.getInstance();
      final instance2 = generator.getInstance();
      expect(identical(instance1, instance2), isTrue);
    });

    test('create non-singleton instance', () {
      final generator = InstanceGenerator<TestClass>(
          () => TestClass('Hello, Alligator!'), false);

      final instance1 = generator.getInstance();
      final instance2 = generator.getInstance();
      expect(identical(instance1, instance2), isFalse);
    });
  });
}
