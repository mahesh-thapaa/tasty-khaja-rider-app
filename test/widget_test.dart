import 'package:flutter_test/flutter_test.dart';
import 'package:rider/main.dart';

void main() {
  testWidgets('App renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(isLoggedIn: false));
    expect(find.byType(MyApp), findsOneWidget);
  });
}
