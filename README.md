# pwa_virtualized_list

A Flutter package that provides a virtualized list widget optimized for Progressive Web Apps (PWAs). This package is designed to handle large lists efficiently by rendering only the visible items, improving performance and user experience in web applications.
This package is particularly useful for applications that require displaying extensive lists of data without compromising on performance, making it ideal for PWAs built with Flutter.

## Features

- Renders only visible items to improve performance.
- Supports dynamic item heights.
- Easy to integrate with existing Flutter apps.

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  pwa_virtualized_list: ^1.0.1
  ```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:pwa_virtualized_list/pwa_virtualized_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Virtualized List Example')),
        body: const SizedBox(
          height: 400, // Set a fixed height for the list
          child: PwaVirtualizedList(
            itemCount: 100,
            itemHeight: 50.0,
            itemBuilder: _itemBuilder,
          ),
        ),
      ),
    );
  }

  static Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      title: Text('Item $index'),
    );
  }
}
```
