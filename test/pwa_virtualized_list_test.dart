import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pwa_virtualized_list/pwa_virtualized_list.dart';

void main() {
  group('VirtualizedList Widget Tests', () {
    testWidgets('Renders visible items correctly', (WidgetTester tester) async {
      // Create testable list widget
      Widget itemBuilder(BuildContext context, int index) {
        return ListTile(title: Text('Item $index'));
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200, // Viewport height
              child: PwaVirtualizedList(
                itemCount: 100,
                itemHeight: 50.0,
                itemBuilder: itemBuilder,
              ),
            ),
          ),
        ),
      );

      // Let layout complete
      await tester.pumpAndSettle();

      // Check for initial items in viewport
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);

      // Scroll down
      await tester.drag(
        find.byKey(const Key('virtualized_list')),
        const Offset(0, -250),
      );
      await tester.pumpAndSettle();

      // Check if new items appear
      expect(find.text('Item 5'), findsOneWidget);
      expect(find.text('Item 6'), findsOneWidget);
      expect(find.text('Item 7'), findsOneWidget);
    });
  });
}
