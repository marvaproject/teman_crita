import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/app_snackbar.dart';
import '../../main.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final _noteController = TextEditingController();
  int? _selectedIndex;
  int _noteLength = 0;

  static const _moods = [
    ('Hebat', 'assets/icons/mood_hebat.png'),
    ('Baik', 'assets/icons/mood_baik.png'),
    ('Biasa', 'assets/icons/mood_biasa.png'),
    ('Sedih', 'assets/icons/mood_sedih.png'),
    ('Cemas', 'assets/icons/mood_cemas.png'),
    ('Tertekan', 'assets/icons/mood_tertekan.png'),
    ('Lelah', 'assets/icons/mood_lelah.png'),
    ('Sangat Buruk', 'assets/icons/mood_sangat_buruk.png'),
  ];

  static const _levelMap = [4, 3, 2, 1, 1, 0, 2, 0];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveMood() {
    final state = AppScope.of(context);
    final level = _selectedIndex != null ? _levelMap[_selectedIndex!] : 3;
    final note = _noteController.text.trim();
    final mood = _moods[_selectedIndex ?? 2];
    state.saveMood(level, note: note.isNotEmpty ? note : null, moodName: mood.$1, iconAsset: mood.$2);
    AppSnackbar.show(context, 'Mood "${mood.$1}" tersimpan!');
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final radii = context.radii;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 360;
    final double titleSize = isSmallScreen ? 26.0 : 30.0;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing.pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mood Check-In',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Gimana perasaanmu hari ini?',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: isSmallScreen ? 14.0 : 16.0,
                        fontWeight: FontWeight.w500,
                        height: 1.55,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Check-in untuk memahami dirimu lebih baik.',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: isSmallScreen ? 14.0 : 16.0,
                        fontWeight: FontWeight.w500,
                        height: 1.55,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/illustration/cloud_mood_heart.png',
                width: 300,
                height: 210,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing.pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(radii.card),
                        border: Border.all(color: AppColors.border.withOpacity(0.06), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.04),
                            offset: const Offset(0, 6),
                            blurRadius: 22,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pilih mood-mu', style: AppTypography.h2),
                          const SizedBox(height: 28),
                          GridView.count(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.66,
                            children: List.generate(_moods.length, (index) {
                              final isSelected = _selectedIndex == index;
                              return GestureDetector(
                                onTap: () => setState(() => _selectedIndex = index),
                                  child: Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.card : AppColors.surface,
                                    borderRadius: BorderRadius.circular(radii.card),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.border.withOpacity(0.14),
                                      width: isSelected ? 1.8 : 1.2,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned.fill(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              _moods[index].$2,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              _moods[index].$1,
                                              style: AppTypography.label.copyWith(
                                                fontSize: 11,
                                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                                                color: isSelected
                                                    ? AppColors.primary
                                                    : AppColors.textSecondary,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        Positioned(
                                          top: -14,
                                          right: -8,
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.check_rounded,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 28),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                            decoration: BoxDecoration(
                              color: AppColors.accentLight.withOpacity(0.56),
                              borderRadius: BorderRadius.circular(radii.card),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/illustration/plant_growth.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 22),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Terima kasih sudah hadir untuk dirimu hari ini',
                                        style: AppTypography.label.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Setiap langkah kecil untuk mengenal dirimu, adalah langkah besar untuk menjadi lebih baik.',
                                        style: AppTypography.body.copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(radii.card),
                        border: Border.all(color: AppColors.border.withOpacity(0.06), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.04),
                            offset: const Offset(0, 6),
                            blurRadius: 22,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Catatan singkat',
                                style: AppTypography.label.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                '$_noteLength/300',
                                style: AppTypography.body.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Stack(
                            children: [
                              TextField(
                                controller: _noteController,
                                maxLines: 6,
                                minLines: 6,
                                maxLength: 300,
                                buildCounter: (_, {required int currentLength, required bool isFocused, required int? maxLength}) => null,
                                onChanged: (v) => setState(() => _noteLength = v.length),
                                decoration: InputDecoration(
                                  hintText: 'Tulis apa yang kamu rasakan atau\nhal yang terjadi hari ini...',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.55,
                                    color: AppColors.textSecondary.withOpacity(0.74),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.surface,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(color: AppColors.border.withOpacity(0.18), width: 1.2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(color: AppColors.border.withOpacity(0.18), width: 1.2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 22,
                                bottom: 22,
                                child: Icon(Icons.eco_rounded, color: AppColors.moodGood, size: 24),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.lock_outline_rounded, size: 18, color: AppColors.textMuted),
                              const SizedBox(width: 10),
                              Text(
                                'Catatan ini hanya bisa kamu lihat.',
                                style: AppTypography.body.copyWith(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 62,
                      child: ElevatedButton(
                        onPressed: _saveMood,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.favorite_rounded, color: Colors.white),
                            const SizedBox(width: 14),
                            Text(
                              'Simpan Mood',
                              style: AppTypography.buttonText.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome_rounded, size: 18, color: AppColors.textMuted),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Check-in secara rutin membantumu mengenal diri lebih baik.',
                            style: AppTypography.body.copyWith(fontSize: 14, color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
