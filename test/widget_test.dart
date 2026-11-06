import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bill_splitter/main.dart';

void main() {
  testWidgets('BillSplitterApp loads and displays Dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const BillSplitterApp());
    expect(find.text('Hi, Roshan'), findsOneWidget);
    expect(find.text('₹1,240'), findsWidgets);
    expect(find.text('Balance Summary'), findsOneWidget);
  });
}
