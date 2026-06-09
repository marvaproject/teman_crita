import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/models/mood_entry.dart';

import '../../main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedDayIndex = 6;

  static const _dashboardMoods = [
    ('Hebat', 'assets/icons/mood_hebat.png'),
    ('Baik', 'assets/icons/mood_baik.png'),
    ('Biasa', 'assets/icons/mood_biasa.png'),
    ('Sedih', 'assets/icons/mood_sedih.png'),
    ('Cemas', 'assets/icons/mood_cemas.png'),
    ('Tertekan', 'assets/icons/mood_tertekan.png'),
    ('Lelah', 'assets/icons/mood_lelah.png'),
    ('Sangat Buruk', 'assets/icons/mood_sangat_buruk.png'),
  ];

  static const _dashboardLevelMap = [4, 3, 2, 1, 1, 0, 2, 0];

  // Map index to assets
  final Map<int, String> _moodIcons = {
    4: 'assets/icons/mood_hebat.png',
    3: 'assets/icons/mood_baik.png',
    2: 'assets/icons/mood_biasa.png',
    1: 'assets/icons/mood_sedih.png',
    0: 'assets/icons/mood_sangat_buruk.png', // Maps to Buruk
  };

  // Map index to descriptions
  final Map<int, String> _moodDescriptions = {
     4: 'Luar biasa! Pertahankan energi positifmu hari ini. Kamu hebat!',
    3: 'Terima kasih sudah check-in! Semoga harimu penuh hal baik.',
    2: 'Hari yang cukup tenang. Tetap jaga keseimbangan dirimu.',
    1: 'Gak apa-apa merasa sedih. Tarik napas, tenangkan dirimu.',
    0: 'Hari yang berat ya? Ingat, kamu gak sendirian menghadapi ini.',
  };

  // Map index to specific mood theme colors for premium border highlights
  final Map<int, Color> _moodThemeColors = {
    4: AppColors.moodHappy,
    3: AppColors.moodGood,
    2: AppColors.moodNeutral,
    1: AppColors.moodSad,
    0: AppColors.moodBad,
  };

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 360;
    final double titleSize = isSmallScreen ? 26.0 : 30.0;
    final double welcomeSubtitleSize = isSmallScreen ? 14.0 : 16.0;
    final double imageWidth = isSmallScreen ? 96.0 : 124.0;
    final double imageHeight = isSmallScreen ? 76.0 : 98.0;

    // Default to 'Baik' (level 3) if no mood is selected yet
    final currentMoodLevel = state.todayMood?.level ?? 3;
    final todayEntry = state.todayMood;
    final currentMoodName = todayEntry?.moodName ?? MoodEntry.labels[currentMoodLevel];
    final currentMoodIcon = todayEntry?.iconAsset ?? (_moodIcons[currentMoodLevel] ?? 'assets/icons/mood_baik.png');
    final currentMoodDesc = _moodDescriptions[currentMoodLevel] ?? 'Semoga harimu menyenangkan!';

    return Scaffold(
      backgroundColor: AppColors.surface, // 0xFFF5F7F8
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                
                // 1. Personal Header Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hai, Marva 👋',
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
                            'Senang melihatmu kembali!\nYuk, terus jaga kesehatan mentalmu hari ini.',
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
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, right: 8.0),
                          child: Image.asset(
                            'assets/illustration/cloud_mascot_header.png',
                            width: imageWidth,
                            height: imageHeight,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(
                                width: imageWidth,
                                height: imageHeight,
                                child: const Icon(
                                  Icons.cloud_queue_rounded,
                                  color: AppColors.primaryLight,
                                  size: 60.0,
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          right: -4.0,
                          top: -8.0,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Badge(
                                backgroundColor: AppColors.error,
                                smallSize: 10.0,
                                alignment: Alignment(0.6, -0.6),
                                child: Icon(
                                  Icons.notifications_none_rounded,
                                  size: 28.0,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // 2. Mood Card
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.04),
                        offset: const Offset(0, 6),
                        blurRadius: 24.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mood Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Mood Hari Ini',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 16.0,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '20 Mei 2024',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),

                      // Selected Mood Row
                      Row(
                        children: [
                          Image.asset(
                            currentMoodIcon,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.primarySurface,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.mood_rounded,
                                  color: AppColors.primary,
                                  size: 50.0,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentMoodName,
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w700,
                                    color: _moodThemeColors[currentMoodLevel] ?? AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  currentMoodDesc,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: AppColors.textSecondary,
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),

                      // Mood Selector (8 mood options: 4x2 grid)
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.78,
                        children: List.generate(_dashboardMoods.length, (index) {
                          final isSelected = todayEntry?.moodName != null
                              ? _dashboardMoods[index].$1 == todayEntry!.moodName
                              : _dashboardLevelMap.indexOf(currentMoodLevel) == index;
                          final level = _dashboardLevelMap[index];
                          final moodColor = _moodThemeColors[level] ?? AppColors.primary;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.white : AppColors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: isSelected
                                  ? Border.all(color: moodColor, width: 1.8)
                                  : null,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: moodColor.withOpacity(0.08),
                                        offset: const Offset(0, 4),
                                        blurRadius: 10,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  _dashboardMoods[index].$2,
                                  width: 32, height: 32, fit: BoxFit.contain,
                                  color: isSelected ? null : AppColors.textSecondary.withOpacity(0.8),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _dashboardMoods[index].$1,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                                    color: isSelected ? moodColor : AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20.0),

                      // Consistency Banner (Soft green solid background, no outlines as requested)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5), // Light emerald/green background (M3 success container)
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            state.setTab(3); // Go to Mood tab
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    // Circular badge for the green leaf icon
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD1FAE5), // Slightly darker green circle
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.eco_rounded,
                                        color: Color(0xFF059669), // Solid green leaf icon
                                        size: 20.0,
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Kamu konsisten 3 hari berturut-turut!',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF047857), // Dark green text
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            'Pertahankan ya, kamu hebat!',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF065F46), // Dark green supporting text
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.0,
                                color: Color(0xFF047857),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

                // 2b. Mood Graph Card (Progress Mood Mingguan)
                _buildMoodGraphCard(state, currentMoodLevel),
                const SizedBox(height: 20.0),

                // 3. Quick Actions Section
                Container(
                  padding: const EdgeInsets.all(20.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Aksi Cepat',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            child: const Text(
                              'Lihat semua →',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            _buildQuickActionTile(Icons.person_search_rounded, 'Temukan\nPsikolog', () {}),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.air_rounded, 'Latihan\nPernapasan', () {}),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.assignment_rounded, 'Jurnal\nRefleksi', () {}),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.favorite_rounded, 'Affirmation\nHarian', () {}),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.people_rounded, 'Relaksasi\nBersama', () {}),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

                // 4. Upcoming Session Card — token-aligned
                Container(
                  // Outer card: padding sesuai AppSpacing.cardPadding (h:14, v:20)
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    // AppRadii.card = 16, section card pakai 24 untuk konsistensi
                    // dengan card lain di dashboard yang sudah pakai 24
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
                      // ── Header: judul + pill chip ──
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // h2 token: 20/w600
                          const Text(
                            'Sesi Mendatang',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              // Pill chip padding: h:12, v:6
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 6.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primarySurface,
                                // AppRadii.pill = 24
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Lihat semua sesi',
                                    // caption token: 12/w500 → w600 untuk interaktif
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // iconInline = 14, dikecilkan sedikit untuk chip
                                    size: 11.0,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // gridGap = 16
                      const SizedBox(height: 16.0),

                      // ── Inner card ──
                      Container(
                        width: double.infinity,
                        // cardPadding: h:14, v:14 (compact untuk inner card)
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: AppColors.surface, // theme surface = 0xFFF5F7F8
                          // AppRadii.card = 16
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // ── Row 1: Avatar + Info ──
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar 64x64 dengan status dot
                                SizedBox(
                                  width: 64.0,
                                  height: 64.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(32.0),
                                        child: Image.network(
                                          'https://i.pravatar.cc/150?u=psy-1',
                                          width: 64.0,
                                          height: 64.0,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              width: 64.0,
                                              height: 64.0,
                                              decoration: const BoxDecoration(
                                                color: AppColors.primarySurface,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: SizedBox(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2.0,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 64.0,
                                              height: 64.0,
                                              decoration: const BoxDecoration(
                                                color: AppColors.primarySurface,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.person_rounded,
                                                color: AppColors.primary,
                                                // iconSection = 20 (sekitar sepertiga avatar)
                                                size: 28.0,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Status dot aktif — kiri bawah
                                      Positioned(
                                        bottom: 0,
                                        left: 2,
                                        child: Container(
                                          width: 14.0,
                                          height: 14.0,
                                          decoration: BoxDecoration(
                                            color: AppColors.success,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              // Match surface color
                                              color: AppColors.surface,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // gridGap = 16 → gap avatar ke info
                                const SizedBox(width: 12.0),

                                // Info: chip + nama
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Chip "Sesi Online"
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 3.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.10),
                                          // AppRadii.iconButtonMin = 12
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: const Text(
                                          'Sesi Online',
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6.0),
                                      // Nama: h3 token = 16/w600
                                      const Text(
                                        'Sesi dengan\nPsikolog Amanda',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                          height: 1.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // gridGap = 16
                            const SizedBox(height: 16.0),

                            // Divider tipis
                            Container(
                              height: 1.0,
                              color: AppColors.border,
                            ),
                            const SizedBox(height: 12.0),

                            // ── Row 2: Tanggal & Waktu inline ──
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  // iconInline = 14
                                  size: 14.0,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 5.0),
                                const Text(
                                  'Rabu, 22 Mei 2024',
                                  // caption token = 12/w500
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                const Icon(
                                  Icons.access_time_rounded,
                                  size: 14.0,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 5.0),
                                const Text(
                                  '10:00 – 11:00 WIB',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            // gridGap = 16
                            const SizedBox(height: 16.0),

                            // ── Row 3: Countdown kiri + Tombol kanan ──
                            Row(
                              children: [
                                // Countdown box — white, rounded button
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0,
                                    vertical: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    // AppRadii.button = 14
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      // caption: 12/w500
                                      Text(
                                        'Mulai dalam',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      // h1 token = 28/w700 → sedikit dikecilkan jadi 22
                                      Text(
                                        '1 hari',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                // Tombol "Lihat Detail" — expanded, pill shape
                                Expanded(
                                  child: SizedBox(
                                    height: 48.0,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.white,
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                      ),
                                      child: Text(
                                        'Lihat Detail',
                                        style: AppTypography.buttonText,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0), // Spacing between Upcoming Session and Reflection Section

                // 5. Refleksi Hari Ini — header di luar card, inner card fluid height
                // ── Header ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Refleksi Hari Ini',
                      style: AppTypography.h2,
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Lihat semua',
                            style: AppTypography.label.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 3.0),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 11.0,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),

                // ── Inner card — fluid height, with a clean border outline, no PNG ──
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E7), // Accent light yellow background
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: const Color(0xFFE5A845).withOpacity(0.3), // Accent yellow border outline
                      width: 1,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quote mark besar
                      Text(
                        '“',
                        style: AppTypography.h1.copyWith(
                          fontSize: 48.0,
                          height: 0.6,
                          color: const Color(0xFFFFD966),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      // Teks kutipan
                      Text(
                        'Kamu tidak harus hebat setiap hari.\nCukup hadir, dan lakukan yang terbaik.',
                        style: AppTypography.body.copyWith(
                          fontSize: 15.0, // standard layout text size
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Tagline
                      Row(
                        children: [
                          const Text(
                            '💛',
                            style: TextStyle(fontSize: 13.0),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Tetaplah lembut pada dirimu.',
                            style: AppTypography.label.copyWith(
                              color: const Color(0xFF92610A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper builder for mood chips
  // Helper builder for action tiles (soft surface, no outline)
  Widget _buildQuickActionTile(
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
        width: 110.0,
        height: 100.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: AppColors.primary,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helper to build the Mood Graph Card ──
  Widget _buildMoodGraphCard(AppState state, int currentMoodLevel) {
    const List<String> days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    const List<String> shortDays = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    const List<String> moodEmojis = [
      '😭 Buruk',
      '😢 Sedih',
      '😐 Biasa',
      '😊 Baik',
      '☀️ Hebat'
    ];

    // Data 7 hari (Minggu mengambil nilai real-time dari hari ini)
    final List<int> weeklyMoods = [3, 2, 1, 4, 2, 3, currentMoodLevel];

    final int selectedLevel = weeklyMoods[_selectedDayIndex];
    final Color selectedColor = _moodThemeColors[selectedLevel] ?? AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
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
          // Header Judul
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grafik Mood 7 Hari',
                style: AppTypography.h2,
              ),
              Text(
                'Sen – Min',
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Detail Hari yang Dipilih (Banner Info Premium)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: selectedColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: selectedColor.withOpacity(0.18),
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sentiment_satisfied_alt_rounded,
                  size: 18.0,
                  color: selectedColor,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    '${days[_selectedDayIndex]}: Mood kamu ${moodEmojis[selectedLevel]}',
                    style: AppTypography.label.copyWith(
                      color: selectedColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // Bar Chart Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              final bool isSelected = _selectedDayIndex == index;
              final int moodLevel = weeklyMoods[index];
              final Color moodColor = _moodThemeColors[moodLevel] ?? AppColors.primary;

              // Hitung tinggi berdasarkan skala 120.0 maks
              // Level 0 (Buruk) -> 24.0, Level 4 (Hebat) -> 120.0
              final double barHeight = 24.0 + (moodLevel * 24.0);

              return GestureDetector(
                onTap: () => setState(() => _selectedDayIndex = index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Batang Grafik
                    Container(
                      width: 28.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            width: 28.0,
                            height: barHeight,
                            decoration: BoxDecoration(
                              color: isSelected ? moodColor : moodColor.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: moodColor.withOpacity(0.24),
                                        offset: const Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ]
                                  : null,
                              border: isSelected
                                  ? Border.all(color: AppColors.white, width: 2.0)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Label Hari
                    Text(
                      shortDays[index],
                      style: AppTypography.caption.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
