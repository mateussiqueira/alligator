import '../../domain/domain.dart';

class InstanceGenerator<T> {
  InstanceGenerator(
    this.instanceCreator,
    bool isSingleton,
  ) : _isFirstGet = isSingleton;

  T? _instance;
  bool _isFirstGet = false;
  final InstanceCreator<T> instanceCreator;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = instanceCreator();
      _isFirstGet = false;
    }
    return _instance ?? instanceCreator();
  }
}
