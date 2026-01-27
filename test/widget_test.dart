import 'package:flutter_test/flutter_test.dart';
import 'package:datac_mobile_app/main.dart';

void main() {
  testWidgets('DATAC app loads', (WidgetTester tester) async {
    // ✅ Correct class name
    await tester.pumpWidget(const DATACApp());

    // Optional: just check app loads
    expect(find.byType(DATACApp), findsOneWidget);
  });
}
