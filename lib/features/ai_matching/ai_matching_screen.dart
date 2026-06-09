import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/app_snackbar.dart';
import '../../core/models/matching_request.dart';
import '../../core/models/psychologist.dart';
import '../marketplace/marketplace_screen.dart';
import '../../main.dart';

enum MatchingPhase { input, scanning, results }

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> with TickerProviderStateMixin {
  MatchingPhase _currentPhase = MatchingPhase.input;
  final _controller = TextEditingController();
  final Set<String> _selectedTags = {};

  Timer? _scanningTimer;
  int _scanningSeconds = 0;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Pulse animation setup for scanning bubble
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scanningTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startScanning(AppState state) {
    final storyText = _controller.text.trim();
    if (storyText.isEmpty) {
      AppSnackbar.show(context, 'Cerita kamu tidak boleh kosong.');
      return;
    }

    setState(() {
      _currentPhase = MatchingPhase.scanning;
      _scanningSeconds = 0;
    });

    // Start breathing animation
    _pulseController.repeat(reverse: true);

    // 3-second animated scan sequence
    _scanningTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _scanningSeconds++;
      });
      if (_scanningSeconds >= 3) {
        timer.cancel();
        _pulseController.stop(); // Stop animation when done
        final request = MatchingRequest(
          story: storyText,
          issueTags: _selectedTags.toList(),
        );
        state.runMatching(request);
        setState(() {
          _currentPhase = MatchingPhase.results;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // Responsive sizing logic to prevent overflows
    final bool isSmallScreen = screenWidth < 360;
    final double titleSize = isSmallScreen ? 26.0 : 30.0;
    final double welcomeSubtitleSize = isSmallScreen ? 14.0 : 16.0;
    final double cardTitleSize = isSmallScreen ? 18.0 : 22.0;
    final double imageWidth = isSmallScreen ? 96.0 : 124.0;
    final double imageHeight = isSmallScreen ? 76.0 : 98.0;

    switch (_currentPhase) {
      case MatchingPhase.input:
        return Scaffold(
          backgroundColor: AppColors.surface,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24.0),

                    // Hero Header Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Temukan Psikolog',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.w800,
                                  height: 1.15,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Ceritakan yang kamu rasakan. Citta bantu temukan psikolog yang cocok.',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: welcomeSubtitleSize,
                                  fontWeight: FontWeight.w500,
                                  height: 1.45,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, right: 8.0),
                          child: Image.asset(
                            'assets/illustration/cloud_heart_chat.png',
                            width: imageWidth,
                            height: imageHeight,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => SizedBox(
                              width: imageWidth,
                              height: imageHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),

                    // Form Card 1: Story Input Area & Compact Tags
                    Container(
                      margin: const EdgeInsets.only(bottom: 24.0),
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: AppColors.border.withOpacity(0.06),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.04),
                            offset: const Offset(0, 6),
                            blurRadius: 22.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2.0),
                                child: Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: AppColors.textPrimary,
                                  size: 24.0,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Text(
                                  'Ceritakan yang sedang kamu rasakan',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: cardTitleSize,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22.0),
                          Stack(
                            children: [
                              TextField(
                                controller: _controller,
                                minLines: 6,
                                maxLines: 8,
                                maxLength: 1000,
                                onChanged: (_) => setState(() {}),
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 16.0,
                                  color: AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Tulis ceritamu di sini...',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary.withOpacity(0.72),
                                  ),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  counterText: '',
                                  contentPadding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 34.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                    borderSide: BorderSide(
                                      color: AppColors.border.withOpacity(0.18),
                                      width: 1.2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                    borderSide: BorderSide(
                                      color: AppColors.border.withOpacity(0.18),
                                      width: 1.2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                    borderSide: const BorderSide(
                                      color: AppColors.primary,
                                      width: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 16.0,
                                bottom: 12.0,
                                child: Text(
                                  '${_controller.text.length}/1000',
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Compact Horizontal Tags row to satisfy MVP spec without visual clutter
                          const SizedBox(height: 20.0),
                          const Text(
                            'Kategori Masalah (Pilih maks 3)',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                'Cemas',
                                'Stres',
                                'Tidur',
                                'Relasi',
                                'Keluarga',
                              ].map((tag) {
                                final bool isSelected = _selectedTags.contains(tag);
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    label: Text(
                                      tag,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 13.0,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          if (_selectedTags.length < 3) {
                                            _selectedTags.add(tag);
                                          } else {
                                            AppSnackbar.show(context, 'Kamu hanya bisa memilih maksimal 3 kategori.');
                                          }
                                        } else {
                                          _selectedTags.remove(tag);
                                        }
                                      });
                                    },
                                    backgroundColor: AppColors.surface,
                                    selectedColor: AppColors.primarySurface,
                                    checkmarkColor: AppColors.primary,
                                    side: BorderSide(
                                      color: isSelected ? AppColors.primary : AppColors.border.withOpacity(0.5),
                                      width: 1.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 20.0),
                          Row(
                            children: const [
                              Icon(
                                Icons.lock_outline_rounded,
                                color: AppColors.textSecondary,
                                size: 16.0,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Semua cerita kamu aman dan rahasia.',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Primary Submit Button
                    Container(
                      width: double.infinity,
                      height: 56.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: _controller.text.trim().isEmpty
                            ? null
                            : [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.22),
                                  offset: const Offset(0, 8),
                                  blurRadius: 18.0,
                                ),
                              ],
                      ),
                      child: ElevatedButton(
                        onPressed: _controller.text.trim().isEmpty
                            ? null
                            : () => _startScanning(state),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                          foregroundColor: AppColors.white,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.auto_awesome_rounded,
                              color: AppColors.white,
                              size: 22.0,
                            ),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                'Temukan Psikolog yang Sesuai',
                                style: AppTypography.buttonText.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ),
        );

      case MatchingPhase.scanning:
        // Text status rotation based on elapsed seconds
        String scanningText = 'Menghubungkan cerita Anda...';
        if (_scanningSeconds == 2) {
          scanningText = 'Menganalisis emosi & kategori...';
        } else if (_scanningSeconds >= 3) {
          scanningText = 'Mencari psikolog terbaik...';
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Pulser animation circle bubble
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.08),
                            blurRadius: 20.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.primary,
                          size: 52.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  // Rotating text indicator
                  Text(
                    scanningText,
                    style: AppTypography.h3.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  // Loading progress bar indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: SizedBox(
                      height: 4.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: const LinearProgressIndicator(
                          color: AppColors.primary,
                          backgroundColor: AppColors.primarySurface,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );

      case MatchingPhase.results:
        final List<Psychologist> results =
            state.matches.isEmpty ? state.repository.psychologists : state.matches;

        return ScreenScaffold(
          title: 'Rekomendasi Psikolog',
          subtitle: 'AI telah mencocokkan psikolog yang paling tepat berdasarkan ceritamu.',
          children: [
            // Recommendations Header
            Text(
              '3 Psikolog Terbaik Untukmu',
              style: AppTypography.label.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12.0),

            // Recommended Psychologist List
            ...results.map((psychologist) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.04),
                      offset: const Offset(0, 4),
                      blurRadius: 20.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar + Info Name
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image.network(
                            'https://i.pravatar.cc/150?u=${psychologist.id}',
                            width: 48.0,
                            height: 48.0,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 48.0,
                                height: 48.0,
                                color: AppColors.primarySurface,
                                child: const Center(
                                  child: SizedBox(
                                    width: 18.0,
                                    height: 18.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 48.0,
                              height: 48.0,
                              color: AppColors.primarySurface,
                              child: const Icon(Icons.person_rounded, color: AppColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                psychologist.name,
                                style: AppTypography.h3,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                psychologist.specialty,
                                style: AppTypography.caption,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),

                    // Rating + Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber, size: 18.0),
                              const SizedBox(width: 4.0),
                              Flexible(
                                child: Text(
                                  '${psychologist.rating}',
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Rp ${psychologist.price} / sesi',
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),

                    // AI Match Reason Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.auto_awesome_rounded,
                            color: AppColors.primary,
                            size: 16.0,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              psychologist.matchReason,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18.0),

                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 44.0,
                      child: ElevatedButton(
                        onPressed: () {
                          state.selectPsychologist(psychologist);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PsychologistDetailScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        ),
                        child: Text(
                          'Lihat Profil',
                          style: AppTypography.buttonText,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 8.0),

            // Search Again Button
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _currentPhase = MatchingPhase.input;
                    _controller.clear();
                    _selectedTags.clear();
                  });
                },
                child: Text(
                  'Cari ulang rekomendasi',
                  style: AppTypography.label.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        );
    }
  }
}
