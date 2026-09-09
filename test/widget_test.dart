import 'package:flutter_test/flutter_test.dart';
import 'package:dyslexia_app/main.dart';

void main() {
  testWidgets('ReadEase home screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ReadEaseApp());

    expect(find.text('ReadEase'), findsOneWidget);
    expect(find.text('Welcome 👋'), findsOneWidget);
    expect(find.text('Read'), findsOneWidget);
    expect(find.text('Read Aloud'), findsOneWidget);
    expect(find.text('Simplify'), findsOneWidget);
    expect(find.text('Phonics Game'), findsOneWidget);
  });
}