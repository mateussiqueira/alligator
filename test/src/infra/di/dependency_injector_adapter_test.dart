import 'package:alligator/alligator.dart' show Alligator;
import 'package:alligator/src/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final DependencyInjector dependencyInjector;

  setUp(() {
    dependencyInjector = HomeModule.initialize();
  });
  test('Should call Injection with correct values', () {
    final controller = dependencyInjector.get<Controller>();
    final value = controller.value;
    expect(value, 1);
  });
}

abstract class Controller {
  final int value;

  Controller(this.value);
}

class HomeController implements Controller {
  @override
  int get value => 1;
}

class HomeModule {
  static Alligator initialize() {
    var alligator = Alligator();

    alligator.register<Controller>(() => HomeController());

    return alligator;
  }
}
