import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/mood_entry.dart';
import '../../main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    4: 'Luar biasa! Pertahankan energi positifmu hari ini.',
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

    // Default to 'Baik' (level 3) if no mood is selected yet
    final currentMoodLevel = state.todayMood?.level ?? 3;
    final currentMoodName = MoodEntry.labels[currentMoodLevel];
    final currentMoodIcon = _moodIcons[currentMoodLevel] ?? 'assets/icons/mood_baik.png';
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hai, Ayu 👋',
                            style: TextStyle(
                              fontSize: 34.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Senang melihatmu kembali!',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Yuk, terus jaga kesehatan mentalmu hari ini.',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Notifications Button with Badge at the top right
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, top: 4.0),
                          child: InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Notifikasi diakses')),
                              );
                            },
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
                        // Mascot Image floating below it
                        Image.asset(
                          'assets/illustration/cloud_mascot_header.png',
                          width: 140.0,
                          height: 110.0,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              width: 140.0,
                              height: 110.0,
                              child: Icon(
                                Icons.cloud_queue_rounded,
                                color: AppColors.primaryLight,
                                size: 60.0,
                              ),
                            );
                          },
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

                      // Mood Selector (5 options: Hebat, Baik, Biasa, Sedih, Buruk)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMoodChip(4, 'Hebat', currentMoodLevel, state),
                          const SizedBox(width: 8.0),
                          _buildMoodChip(3, 'Baik', currentMoodLevel, state),
                          const SizedBox(width: 8.0),
                          _buildMoodChip(2, 'Biasa', currentMoodLevel, state),
                          const SizedBox(width: 8.0),
                          _buildMoodChip(1, 'Sedih', currentMoodLevel, state),
                          const SizedBox(width: 8.0),
                          _buildMoodChip(0, 'Buruk', currentMoodLevel, state),
                        ],
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Menuju ke detail tracker mood...')),
                            );
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
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Lihat semua aksi diakses')),
                              );
                            },
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
                            _buildQuickActionTile(Icons.person_search_rounded, 'Temukan\nPsikolog', () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Membuka pencarian psikolog...')),
                              );
                            }),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.air_rounded, 'Latihan\nPernapasan', () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Memulai latihan pernapasan...')),
                              );
                            }),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.assignment_rounded, 'Jurnal\nRefleksi', () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Membuka jurnal refleksi...')),
                              );
                            }),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.favorite_rounded, 'Affirmation\nHarian', () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Menampilkan afirmasi hari ini...')),
                              );
                            }),
                            const SizedBox(width: 12.0),
                            _buildQuickActionTile(Icons.people_rounded, 'Relaksasi\nBersama', () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Menghubungkan relaksasi grup...')),
                              );
                            }),
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
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Semua sesi konsultasi diakses')),
                              );
                            },
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
                                        child: Image.asset(
                                          'assets/images/psychologist_amanda.png',
                                          width: 64.0,
                                          height: 64.0,
                                          fit: BoxFit.cover,
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
                                    // Tinggi standar button = 48 (material baseline)
                                    height: 48.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Detail sesi konsultasi diakses'),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.white,
                                        elevation: 0,
                                        // AppRadii.pill = 24 → full pill shape
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                      ),
                                      child: const Text(
                                        'Lihat Detail',
                                        // buttonText token: 15/w600
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                const SizedBox(height: 20.0),

                // 5. Refleksi Hari Ini — header di luar card, inner card fluid height
                // ── Header ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // h2 token: 20/w600
                    const Text(
                      'Refleksi Hari Ini',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Semua refleksi diakses')),
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Lihat semua',
                            // label token: 13/w600
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 3.0),
                          Icon(
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

                // ── Inner card — fluid height, no fixed ──
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    // Accent light yellow background
                    color: const Color(0xFFFFF8E7),
                    child: Stack(
                      children: [
                        // Konten kiri — padding right 150 agar tidak tertimpa maskot
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 18.0, 150.0, 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Quote mark besar — amber
                              const Text(
                                '\u201C\u201C',
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFFFD966),
                                  height: 0.9,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              // Teks kutipan — body: 14/w500
                              const Text(
                                'Kamu tidak harus hebat setiap hari.\nCukup hadir, dan lakukan yang terbaik.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              // Tagline — amber bold
                              const Row(
                                children: [
                                  Text(
                                    '💛',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Tetaplah lembut pada dirimu.',
                                    // label token: 13/w600
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF92610A),
                                    ),
                                  ),
                                ],
                              ),
                              // Bottom spacing agar mascot tidak terlalu mepet
                              const SizedBox(height: 4.0),
                            ],
                          ),
                        ),

                        // Maskot mepet kanan-bawah
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/illustration/reflection_cloud.png',
                            width: 140.0,
                            height: 130.0,
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomRight,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                width: 130.0,
                                height: 120.0,
                                child: Icon(
                                  Icons.spa_rounded,
                                  color: Color(0xFFD97706),
                                  size: 60.0,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 120.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper builder for mood chips
  Widget _buildMoodChip(
    int level,
    String label,
    int currentSelected,
    AppState state,
  ) {
    final bool isSelected = currentSelected == level;
    final Color moodThemeColor = _moodThemeColors[level] ?? AppColors.primary;

    return Expanded(
      child: GestureDetector(
        onTap: () => state.saveMood(level),
        child: Container(
          height: 80.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.surface, // Background container, no outlines for unselected
            borderRadius: BorderRadius.circular(18.0),
            border: isSelected
                ? Border.all(
                    color: moodThemeColor, // Specific mood theme color highlight
                    width: 1.8,
                  )
                : null, // No outlines for unselected state
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: moodThemeColor.withOpacity(0.08),
                      offset: const Offset(0, 4),
                      blurRadius: 10.0,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _moodIcons[level] ?? 'assets/icons/mood_baik.png',
                width: 32.0,
                height: 32.0,
                fit: BoxFit.contain,
                color: isSelected ? null : AppColors.textSecondary.withOpacity(0.8), // Soft grey tint for unselected mascot
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.sentiment_satisfied_alt_rounded,
                    color: isSelected ? moodThemeColor : AppColors.textSecondary,
                    size: 24.0,
                  );
                },
              ),
              const SizedBox(height: 4.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? moodThemeColor : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}
