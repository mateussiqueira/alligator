import '../domain.dart';

abstract class DependencyInjector {
  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = false,
  });

  T get<T extends Object>();

  call<T extends Object>();
}
