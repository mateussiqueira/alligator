import 'package:alligator/alligator.dart';
import 'package:test/test.dart';

class TestClass {
  final String data;
  TestClass(this.data);
}

void main() {
  late Alligator di;

  setUp(() {
    di = Alligator();
  });

  test('register and get instance', () {
    di.register<TestClass>(() => TestClass('Hello, Alligator!'),
        isSingleton: false);

    final instance = di.get<TestClass>();
    expect(instance, isA<TestClass>());
    expect(instance.data, 'Hello, Alligator!');
  });

  test('register and get singleton', () {
    di.register<TestClass>(() => TestClass('Hello, Alligator!'),
        isSingleton: true);

    final instance1 = di.get<TestClass>();
    final instance2 = di.get<TestClass>();
    expect(identical(instance1, instance2), isTrue);
  });

  test('register and get non-singleton', () {
    di.register<TestClass>(() => TestClass('Hello, Alligator!'),
        isSingleton: false);

    final instance1 = di.get<TestClass>();
    final instance2 = di.get<TestClass>();
    expect(identical(instance1, instance2), isFalse);
  });

  // test('get unregistered instance', () {
  //   expect(
  //       () => di.get<TestClass>(),
  //       throwsA(isA<Exception>().having((e) => e.toString(),
  //           'Exception message', '[Exception] Instance TestClass not found')));
  // });
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
