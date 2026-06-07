import 'package:flutter_test/flutter_test.dart';

import 'package:teman_crita/main.dart';

void main() {
  testWidgets('first launch shows onboarding and then auth screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Karena Kamu Gak Sendirian'), findsOneWidget);

    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pump();

    expect(find.text('Masuk ke TemanCrita'), findsOneWidget);
  });

  testWidgets('login opens the MVP app shell', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pump();
    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Halo, Nadya'), findsOneWidget);
    expect(find.text('Mood check-in'), findsOneWidget);
  });
}
