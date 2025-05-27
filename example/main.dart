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
      title: 'Flutter Web Virtualized List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VirtualizedListPage(),
    );
  }
}

class VirtualizedListPage extends StatelessWidget {
  const VirtualizedListPage({super.key});

  final List<String> imageUrls = const [
    'https://picsum.photos/id/10/500/500',
    'https://picsum.photos/id/20/500/500',
    'https://picsum.photos/id/30/500/500',
    'https://picsum.photos/id/40/500/500',
    'https://picsum.photos/id/50/500/500',
    'https://picsum.photos/id/60/500/500',
    'https://picsum.photos/id/70/500/500',
    'https://picsum.photos/id/80/500/500',
    'https://picsum.photos/id/90/500/500',
    'https://picsum.photos/id/100/500/500',
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> largeList = List.generate(
      10000,
      (index) => 'Item $index',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Virtualized List Example')),
      body: PwaVirtualizedList(
        itemCount: largeList.length,
        itemHeight: 50.0,
        itemBuilder: (context, index) {
          final String imageUrl =
              '${imageUrls[index % imageUrls.length]}?t=$index';

          return ListTile(
            leading: Image.network(
              imageUrl,
            ),
            title: Text(largeList[index]),
          );
        },
      ),
    );
  }
}
