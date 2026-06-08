import 'package:flutter_test/flutter_test.dart';

import 'package:teman_crita/main.dart';

void main() {
  testWidgets('first launch shows onboarding and then auth screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    // Advance the timer past the 3-second splash screen transition
    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Teman untuk\nsetiap cerita dan perasaanmu'), findsOneWidget);

    // Scroll to the button in the SingleChildScrollView so it can be hit-tested
    await tester.ensureVisible(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();

    expect(find.text('Selamat Datang Kembali!'), findsOneWidget);
  });

  testWidgets('login opens the MVP app shell', (tester) async {
    await tester.pumpWidget(const MyApp());
    // Advance the timer past the 3-second splash screen transition
    await tester.pump(const Duration(seconds: 3));

    // Scroll to the button in the SingleChildScrollView so it can be hit-tested
    await tester.ensureVisible(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Hai, Ayu 👋'), findsOneWidget);
    expect(find.text('Mood Hari Ini'), findsOneWidget);
  });
}
