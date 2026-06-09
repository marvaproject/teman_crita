import 'package:flutter/material.dart';
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
    
    await tester.ensureVisible(find.text('Masuk'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Hai, Ayu 👋'), findsOneWidget);
    expect(find.text('Mood Hari Ini'), findsOneWidget);
  });

  testWidgets('MatchingScreen flow works: input -> scanning -> results', (tester) async {
    await tester.pumpWidget(const MyApp());
    // Advance splash screen transition
    await tester.pump(const Duration(seconds: 3));

    // Onboarding -> Auth
    await tester.ensureVisible(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();

    // Login -> App Shell
    await tester.ensureVisible(find.text('Masuk'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    // Verify we are on home tab
    expect(find.text('Hai, Ayu 👋'), findsOneWidget);
    
    // Tap on the "Psikolog" bottom navigation tab
    await tester.tap(find.text('Psikolog'));
    await tester.pumpAndSettle();

    // Now we are on the MatchingScreen input phase
    expect(find.text('Ceritakan apa yang sedang kamu rasakan.'), findsAtLeastNWidgets(1));

    final btnFinder = find.text('Temukan Psikolog yang Sesuai');
    expect(btnFinder, findsOneWidget);

    // Enter a story
    await tester.enterText(find.byType(TextField).first, 'Saya merasa sangat tertekan dengan pekerjaan saya baru-baru ini.');
    await tester.pump();

    // Tap "Temukan Psikolog yang Sesuai"
    await tester.tap(btnFinder);
    await tester.pump(); // Transitions to scanning phase

    // Verify scanning phase text starts
    expect(find.text('Menghubungkan cerita Anda...'), findsOneWidget);

    // Advance 1 second
    await tester.pump(const Duration(seconds: 1));
    // Verify scanning text at 2 seconds
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Menganalisis emosi & kategori...'), findsOneWidget);

    // Advance to 3 seconds
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // We should now be in the results phase
    expect(find.text('Rekomendasi Psikolog'), findsOneWidget);
    expect(find.text('3 Psikolog Terbaik Untukmu'), findsOneWidget);
    expect(find.text('Cari ulang rekomendasi'), findsOneWidget);
  });
}
