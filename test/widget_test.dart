import 'package:flutter_test/flutter_test.dart';
import 'package:suorotsav_2026/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ManthanApp());
    expect(find.text('MANTHAN 2026'), findsOneWidget);
  });
}
