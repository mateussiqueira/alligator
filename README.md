# Alligator

Alligator is a lightweight and easy-to-use dependency injection library for Dart.

- [English](#english)
- [Português](#português)

---

## English

### How it works

Alligator allows you to register classes with a dependency injector and easily retrieve instances of those classes when needed. It supports both singleton and non-singleton instances, giving you flexibility in managing your dependencies.

### How to use

#### 1. Add Alligator to your project

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  alligator: ^1.0.0
  ```

## 2. Create a dependency injector

Create an instance of the Alligator class to use as your dependency injector:

```dart
import 'package:alligator/alligator.dart';

final di = Alligator();
```


#### 3. Register your dependencies
Register the classes you want to use with the dependency injector:

```dart
di.register<YourClass>(() => YourClass(), isSingleton: false);
```

isSingleton is an optional parameter. Set it to true if you want to create a singleton instance, or false if you want to create a new instance every time you request it.

#### 4. Retrieve instances
Use the `get<T>` method to retrieve instances of your registered classes:

```dart
final instance = di.get<YourClass>();
```

That's it! You're now ready to use Alligator to manage your dependencies.

Example
Here's a simple example demonstrating how to use Alligator:

```dart
import 'package:alligator/alligator.dart';

class Greeter {
  final String greeting;

  Greeter(this.greeting);
}

void main() {
  final di = Alligator();

  di.register<Greeter>(() => Greeter('Hello, Alligator!'));

  final greeter = di.get<Greeter>();
  print(greeter.greeting);
}
```

In this example, the Greeter class is registered with the dependency injector, and an instance of the class is retrieved using the get<Greeter> method.
