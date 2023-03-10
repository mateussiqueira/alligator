import 'package:collection/collection.dart';

import '../../domain/domain.dart';
import 'di.dart';

class Alligator implements DependencyInjector {
  Alligator._();
  static final _singleton = Alligator._();
  factory Alligator() => _singleton;

  final _instanceMap = <Type, InstanceGenerator<Object>>{};

  @override
  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = false,
  }) =>
      _instanceMap[instance.runtimeType] = InstanceGenerator(
        instance,
        isSingleton,
      );

  @override
  T get<T extends Object>() {
    final instance = findInstance<T>()?.getInstance();

    if (instance != null && instance is T) {
      return instance;
    }
    throw Exception('[Exception] Instance $T not found');
  }

  InstanceGenerator<Object>? findInstance<T extends Object>() {
    final searchInstance = _instanceMap.entries
        .toList()
        .firstWhereOrNull(
          (b) => b.value.instanceCreator is InstanceCreator<T>,
        )
        ?.value;
    if (searchInstance != null) {
      return searchInstance;
    }
    return _instanceMap[T];
  }

  @override
  call<T extends Object>() => get<T>();
}
