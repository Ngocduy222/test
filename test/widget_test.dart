import 'package:flutter_test/flutter_test.dart';
import 'package:moneymate/main.dart';

void main() {
  testWidgets('MoneyMate displays dashboard', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Ngân sách tháng 10/2026'), findsOneWidget);
    expect(find.text('18.000.000₫'), findsOneWidget);
  });
}
