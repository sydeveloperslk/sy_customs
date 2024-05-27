<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package helps to use our custom widgets and functions in varius situations

## Features
    - create custom widgets
    - create custom functions

## Getting started
```dart
import 'package:sy_customs/sy_customs.dart';

```


## Usage
 

```dart
void syCustomLoadingBox(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: const LinearProgressIndicator(),
      );
    },
  );
}
```

## Additional information
if you have any issues or sugestions to this package feel free to contact sydeveloperslk@gmail.com
