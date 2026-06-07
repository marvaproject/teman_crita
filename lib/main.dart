import 'dart:async';

import 'package:flutter/material.dart';

import 'core/data/demo_repository.dart';
import 'core/models/booking.dart';
import 'core/models/matching_request.dart';
import 'core/models/mood_entry.dart';
import 'core/models/psychologist.dart';
import 'core/models/trial_session.dart';
import 'core/theme/app_colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final state = AppState();

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TemanCrita',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          scaffoldBackgroundColor: AppColors.background,
          useMaterial3: true,
        ),
        home: ListenableBuilder(
          listenable: state,
          builder: (context, _) {
            if (!state.seenOnboarding) return const OnboardingScreen();
            if (!state.isLoggedIn) return const AuthScreen();
            return const AppShell();
          },
        ),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  final repository = const DemoRepository();
  bool seenOnboarding = false;
  bool isLoggedIn = false;
  int tabIndex = 0;
  MoodEntry? todayMood;
  List<Psychologist> matches = const [];
  Psychologist? selectedPsychologist;
  BookingDraft? booking;

  void completeOnboarding() {
    seenOnboarding = true;
    notifyListeners();
  }

  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    tabIndex = 0;
    notifyListeners();
  }

  void setTab(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void saveMood(int level) {
    todayMood = MoodEntry.create(level: level);
    notifyListeners();
  }

  void runMatching(MatchingRequest request) {
    matches = repository.match(request);
    tabIndex = 2;
    notifyListeners();
  }

  void selectPsychologist(Psychologist psychologist) {
    selectedPsychologist = psychologist;
    notifyListeners();
  }

  void startBooking({required bool bundle}) {
    final psychologist = selectedPsychologist ?? repository.psychologists.first;
    booking = bundle
        ? BookingDraft.bundle(
            psychologistId: psychologist.id,
            slotLabel: psychologist.availableSlot,
            amount: 360000,
          )
        : BookingDraft.single(
            psychologistId: psychologist.id,
            slotLabel: psychologist.availableSlot,
            amount: psychologist.price,
          );
    notifyListeners();
  }

  void selectPayment(PaymentMethod method) {
    booking = booking?.selectPaymentMethod(method);
    notifyListeners();
  }

  void confirmPayment() {
    booking = booking?.markPaymentSuccess(
      transactionId: 'demo-${DateTime.now().millisecondsSinceEpoch}',
    );
    notifyListeners();
  }
}

class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.state, required super.child});

  final AppState state;

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppScope>()!.state;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => state != oldWidget.state;
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.cloud_outlined,
                  size: 56,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Karena Kamu Gak Sendirian',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'TemanCrita membantu kamu check-in mood, cerita ke AI, dan menemukan psikolog yang cocok.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.45),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Mulai Sekarang',
                icon: Icons.arrow_forward,
                onPressed: state.completeOnboarding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return ScreenScaffold(
      title: 'Masuk ke TemanCrita',
      subtitle: 'Prototype ini siap disambungkan ke Supabase Auth.',
      children: [
        const AppTextField(label: 'Email', hint: 'nama@email.com'),
        const SizedBox(height: 12),
        const AppTextField(label: 'Password', hint: 'Minimal 8 karakter'),
        const SizedBox(height: 24),
        PrimaryButton(label: 'Masuk', icon: Icons.login, onPressed: state.login),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: state.login,
          child: const SizedBox(
            width: double.infinity,
            child: Center(child: Text('Daftar akun baru')),
          ),
        ),
      ],
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final pages = [
      const DashboardScreen(),
      const ExploreScreen(),
      const MatchingScreen(),
      const MoodScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: ListenableBuilder(
        listenable: state,
        builder: (context, _) => pages[state.tabIndex],
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: state,
        builder: (context, _) {
          return NavigationBar(
            selectedIndex: state.tabIndex,
            onDestinationSelected: state.setTab,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.search_outlined), label: 'Eksplor'),
              NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'Curhat AI'),
              NavigationDestination(icon: Icon(Icons.mood_outlined), label: 'Mood'),
              NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
            ],
          );
        },
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return ScreenScaffold(
      title: 'Halo, Nadya',
      subtitle: 'Mulai dari yang paling ringan hari ini.',
      children: [
        MoodCheckCard(selectedLevel: state.todayMood?.level, onSelected: state.saveMood),
        const SizedBox(height: 16),
        InfoCard(
          icon: Icons.calendar_today_outlined,
          title: 'Sesi mendatang',
          body: state.booking?.bookingStatus == BookingStatus.confirmed
              ? 'Sesi aktif pada ${state.booking!.slotLabel}.'
              : 'Belum ada sesi. AI matching bisa bantu cari psikolog cocok.',
          actionLabel: 'Mulai Cerita',
          onAction: () => state.setTab(2),
        ),
        const SizedBox(height: 16),
        InfoCard(
          icon: Icons.spa_outlined,
          title: 'Reset 3 menit',
          body: 'Tarik napas pelan, tulis satu kalimat, lalu pilih afirmasi.',
          actionLabel: 'Check-in Mood',
          onAction: () => state.setTab(3),
        ),
      ],
    );
  }
}

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return ScreenScaffold(
      title: 'Mood Hari Ini',
      subtitle: 'Pilih kondisi yang paling dekat dengan perasaanmu.',
      children: [
        MoodCheckCard(selectedLevel: state.todayMood?.level, onSelected: state.saveMood),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppColors.cardDeco(color: AppColors.primaryLight),
          child: Text(
            state.todayMood == null
                ? 'Belum ada cerita hari ini. Mulai dari yang paling ringan.'
                : 'Tercatat: ${state.todayMood!.label}. Terima kasih sudah mampir ke diri sendiri.',
          ),
        ),
      ],
    );
  }
}

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  final controller = TextEditingController();
  final selectedTags = <String>{};
  bool submitted = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final tags = ['cemas', 'kerja', 'tidur', 'relasi', 'keluarga'];
    return ScreenScaffold(
      title: 'Curhat AI',
      subtitle: 'Ceritakan singkat. Kami bantu pilih psikolog yang cocok.',
      children: [
        AppTextField(
          label: 'Cerita kamu',
          hint: 'Aku akhir-akhir ini...',
          controller: controller,
          minLines: 5,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            final selected = selectedTags.contains(tag);
            return FilterChip(
              selected: selected,
              label: Text(tag),
              onSelected: (_) {
                setState(() {
                  if (selected) {
                    selectedTags.remove(tag);
                  } else if (selectedTags.length < 3) {
                    selectedTags.add(tag);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: 'Temukan Psikolog Untukku',
          icon: Icons.auto_awesome,
          onPressed: () {
            final request = MatchingRequest(
              story: controller.text,
              issueTags: selectedTags.toList(),
            );
            if (!request.isValid) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Isi cerita dan pilih maksimal 3 kategori.')),
              );
              return;
            }
            state.runMatching(request);
            setState(() => submitted = true);
          },
        ),
        if (submitted) ...[
          const SizedBox(height: 20),
          ...state.matches.map((psychologist) {
            return PsychologistCard(
              psychologist: psychologist,
              onTap: () {
                state.selectPsychologist(psychologist);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PsychologistDetailScreen()),
                );
              },
            );
          }),
        ],
      ],
    );
  }
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return ScreenScaffold(
      title: 'Eksplor Psikolog',
      subtitle: 'Pilih berdasarkan spesialisasi, bahasa, dan slot.',
      children: state.repository.psychologists.map((psychologist) {
        return PsychologistCard(
          psychologist: psychologist,
          onTap: () {
            state.selectPsychologist(psychologist);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PsychologistDetailScreen()),
            );
          },
        );
      }).toList(),
    );
  }
}

class PsychologistDetailScreen extends StatelessWidget {
  const PsychologistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final psychologist = state.selectedPsychologist ?? state.repository.psychologists.first;
    return ScreenScaffold(
      title: psychologist.name,
      subtitle: psychologist.specialty,
      showBack: true,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppColors.cardDeco(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(psychologist.bio),
              const SizedBox(height: 16),
              Text('Rating ${psychologist.rating} | ${psychologist.languages.join(', ')}'),
              const SizedBox(height: 8),
              Text('Mulai Rp ${psychologist.price} | ${psychologist.availableSlot}'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          label: 'Coba Chat 10 Menit',
          icon: Icons.chat_bubble_outline,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const TrialChatScreen()),
            );
          },
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {
            state.startBooking(bundle: false);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BookingScreen()),
            );
          },
          child: const SizedBox(
            width: double.infinity,
            child: Center(child: Text('Booking Sesi Penuh')),
          ),
        ),
      ],
    );
  }
}

class TrialChatScreen extends StatefulWidget {
  const TrialChatScreen({super.key});

  @override
  State<TrialChatScreen> createState() => _TrialChatScreenState();
}

class _TrialChatScreenState extends State<TrialChatScreen> {
  int remaining = 600;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => remaining = remaining > 0 ? remaining - 1 : 0);
      if (remaining == 0) {
        timer?.cancel();
        _showExpiredDialog();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _showExpiredDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Trial selesai'),
          content: const Text(
            'Waktu coba chat sudah habis. Kalau nyaman, lanjutkan ke sesi penuh.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Nanti Saja'),
            ),
            FilledButton(
              onPressed: () {
                final state = AppScope.of(context);
                state.startBooking(bundle: false);
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const BookingScreen()),
                );
              },
              child: const Text('Booking Sekarang'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = TrialSession(remainingSeconds: remaining);
    return ScreenScaffold(
      title: 'Trial Chat',
      subtitle: session.state == TrialState.warning
          ? 'Waktu hampir habis, kamu tetap aman.'
          : 'Coba ngobrol ringan selama 10 menit.',
      showBack: true,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: AppColors.cardDeco(color: AppColors.primaryLight),
          child: Row(
            children: [
              const Icon(Icons.timer_outlined, color: AppColors.primary),
              const SizedBox(width: 10),
              Text(session.clock, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const ChatBubble(
          text: 'Halo, aku di sini buat dengar dulu. Apa yang paling berat hari ini?',
        ),
        const ChatBubble(
          fromUser: true,
          text: 'Aku lagi susah tidur dan kepikiran kerja terus.',
        ),
        const ChatBubble(
          text: 'Kedengarannya melelahkan. Kita bisa mulai dari satu hal kecil yang bisa kamu kendalikan malam ini.',
        ),
      ],
    );
  }
}

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final booking = state.booking;
        final psychologist =
            state.selectedPsychologist ?? state.repository.psychologists.first;
        return ScreenScaffold(
          title: 'Booking Sesi',
          subtitle: 'Ringkasan sesi dan pembayaran.',
          showBack: true,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: AppColors.cardDeco(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    psychologist.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(booking?.slotLabel ?? psychologist.availableSlot),
                  const SizedBox(height: 8),
                  Text('Total Rp ${booking?.amount ?? psychologist.price}'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => state.startBooking(bundle: true),
              child: const SizedBox(
                width: double.infinity,
                child: Center(child: Text('Pilih Bundle 3 Sesi - Rp 360000')),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Metode Pembayaran',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            PaymentTile(
              label: 'QRIS',
              selected: booking?.paymentMethod == PaymentMethod.qris,
              onTap: () => state.selectPayment(PaymentMethod.qris),
            ),
            PaymentTile(
              label: 'Virtual Account',
              selected: booking?.paymentMethod == PaymentMethod.virtualAccount,
              onTap: () => state.selectPayment(PaymentMethod.virtualAccount),
            ),
            PaymentTile(
              label: 'GoPay',
              selected: booking?.paymentMethod == PaymentMethod.gopay,
              onTap: () => state.selectPayment(PaymentMethod.gopay),
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: 'Bayar Sekarang',
              icon: Icons.payments_outlined,
              onPressed: booking?.paymentMethod == null
                  ? null
                  : () {
                      state.confirmPayment();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const PaymentSuccessScreen(),
                        ),
                      );
                    },
            ),
          ],
        );
      },
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return ScreenScaffold(
      title: 'Pembayaran Berhasil',
      subtitle: 'Sesi kamu sudah aktif.',
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppColors.cardDeco(color: AppColors.primaryLight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 42),
              const SizedBox(height: 12),
              Text('Status: ${state.booking?.bookingStatus.name ?? 'confirmed'}'),
              Text('Transaksi: ${state.booking?.transactionId ?? '-'}'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: 'Kembali ke Home',
          icon: Icons.home_outlined,
          onPressed: () {
            state.setTab(0);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return ScreenScaffold(
      title: 'Profil Saya',
      subtitle: 'Ringkasan akun dan preferensi.',
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppColors.cardDeco(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nadya Putri', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 6),
              Text('nadya@example.com'),
              SizedBox(height: 14),
              Text('Notifikasi mood, sesi, dan pembayaran aktif.'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        OutlinedButton(
          onPressed: state.logout,
          child: const SizedBox(
            width: double.infinity,
            child: Center(child: Text('Keluar')),
          ),
        ),
      ],
    );
  }
}

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.showBack = false,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBack ? AppBar(backgroundColor: AppColors.background, title: Text(title)) : null,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (!showBack) ...[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 22),
            ] else ...[
              Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 18),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}

class MoodCheckCard extends StatelessWidget {
  const MoodCheckCard({
    super.key,
    required this.selectedLevel,
    required this.onSelected,
  });

  final int? selectedLevel;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: AppColors.cardDeco(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mood check-in', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(MoodEntry.labels.length, (index) {
              return ChoiceChip(
                selected: selectedLevel == index,
                label: Text(MoodEntry.labels[index]),
                onSelected: (_) => onSelected(index),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PsychologistCard extends StatelessWidget {
  const PsychologistCard({
    super.key,
    required this.psychologist,
    required this.onTap,
  });

  final Psychologist psychologist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: AppColors.cardDeco(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(psychologist.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(psychologist.specialty),
              const SizedBox(height: 10),
              Text(psychologist.matchReason),
              const SizedBox(height: 10),
              Text(
                '${psychologist.rating} rating | Rp ${psychologist.price} | ${psychologist.availableSlot}',
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: AppColors.cardDeco(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(body),
          const SizedBox(height: 12),
          TextButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text, this.fromUser = false});

  final String text;
  final bool fromUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: fromUser ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(color: fromUser ? Colors.white : AppColors.textPrimary),
        ),
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: AppColors.primary,
      ),
      title: Text(label),
      onTap: onTap,
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.minLines = 1,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: minLines == 1 ? 1 : 8,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Flexible(child: Text(label, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
