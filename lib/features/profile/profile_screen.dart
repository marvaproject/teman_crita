import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../../core/utils/app_snackbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final radii = context.radii;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                Text('Profil Saya', style: AppTypography.h1),
                const SizedBox(height: 10),
                Text(
                  'Kelola informasi akun dan pantau perjalanan kesehatan mentalmu.',
                  style: AppTypography.body.copyWith(color: AppColors.textSecondary, fontSize: 15),
                ),
                const SizedBox(height: 24),
                // Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
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
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/profil_marva.jpeg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primarySurface,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.person_rounded, size: 50, color: AppColors.primary),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: AppColors.card,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primarySurface, width: 3),
                                  ),
                                  child: const Icon(Icons.camera_alt_outlined, size: 18, color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Marva Athatillah',
                                    style: AppTypography.h2.copyWith(fontSize: 22, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 8),
                                Text('marva.a@email.com',
                                    style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
                                const SizedBox(height: 4),
                                Text('Bergabung sejak 15 April 2024',
                                    style: AppTypography.body.copyWith(color: AppColors.textSecondary, fontSize: 13)),
                                const SizedBox(height: 4),
                                Text('Jakarta, Indonesia',
                                    style: AppTypography.body.copyWith(color: AppColors.textSecondary, fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            AppSnackbar.show(context, 'Edit profil akan tersedia segera');
                          },
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit Profil'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary, width: 1.2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Stats Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(radii.card),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.035),
                        offset: const Offset(0, 6),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(child: _StatTile(icon: Icons.sentiment_satisfied_alt_rounded, value: '7', label: 'Sesi Selesai')),
                        SizedBox(width: 8),
                        Expanded(child: _StatTile(icon: Icons.calendar_month_outlined, value: '12', label: 'Hari Aktif')),
                        SizedBox(width: 8),
                        Expanded(child: _StatTile(icon: Icons.star_border_rounded, value: '4.8', label: 'Rata-rata Mood')),
                        SizedBox(width: 8),
                        Expanded(child: _StatTile(icon: Icons.favorite_border_rounded, value: '3', label: 'Psikolog')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Mood History Card
                _SectionCard(
                  radii: radii.card,
                  title: 'Riwayat Mood',
                  subtitle: 'Bagaimana perasaanmu dalam 7 hari terakhir?',
                  trailing: _LinkArrow(label: 'Lihat semua'),
                  child: _MoodHistoryRow(),
                ),
                const SizedBox(height: 16),
                // Session History Card
                _SectionCard(
                  radii: radii.card,
                  title: 'Riwayat Sesi',
                  trailing: _LinkArrow(label: 'Lihat semua'),
                  child: Column(
                    children: [
                      _SessionRow(
                        name: 'Psik. Amanda Putri, M.Psi',
                        date: '22 Mei 2024, 10:00 WIB',
                        session: 'Online Session  •  60 menit',
                        status: 'Selesai',
                        isScheduled: false,
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      _SessionRow(
                        name: 'Psik. Reza Pratama, M.Psi',
                        date: '10 Mei 2024, 13:00 WIB',
                        session: 'Online Session  •  60 menit',
                        status: 'Selesai',
                        isScheduled: false,
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      _SessionRow(
                        name: 'Psik. Nadhira Aulia, M.Psi',
                        date: '25 Apr 2024, 09:00 WIB',
                        session: 'Online Session  •  60 menit',
                        status: 'Dijadwalkan',
                        isScheduled: true,
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary.withOpacity(0.45), width: 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                          ),
                          child: const Text('Lihat Semua Riwayat Sesi'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Settings Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
                  child: const Column(
                    children: [
                      _SettingsRow(icon: Icons.settings_outlined, title: 'Pengaturan Akun', subtitle: 'Kelola akun, keamanan, dan preferensi'),
                      _SettingsDivider(),
                      _SettingsRow(icon: Icons.notifications_none_rounded, title: 'Notifikasi', subtitle: 'Atur preferensi notifikasi'),
                      _SettingsDivider(),
                      _SettingsRow(icon: Icons.shield_outlined, title: 'Privasi & Keamanan', subtitle: 'Kelola data dan privasi akunmu'),
                      _SettingsDivider(),
                      _SettingsRow(icon: Icons.help_outline_rounded, title: 'Bantuan & Dukungan', subtitle: 'Pusat bantuan dan hubungi kami'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.icon, required this.value, required this.label});

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.14), width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: AppColors.primary),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 44);
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.radii, required this.title, this.subtitle, this.trailing, required this.child});

  final double radii;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(radii),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.h2),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(subtitle!, style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _LinkArrow extends StatelessWidget {
  const _LinkArrow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.primary),
        ],
      ),
    );
  }
}

class _MoodHistoryRow extends StatelessWidget {
  const _MoodHistoryRow();

  static const _items = [
    ('Baik', '20 Mei', 'assets/icons/mood_baik.png'),
    ('Hebat', '19 Mei', 'assets/icons/mood_hebat.png'),
    ('Biasa', '18 Mei', 'assets/icons/mood_biasa.png'),
    ('Sedih', '17 Mei', 'assets/icons/mood_sedih.png'),
    ('Cemas', '16 Mei', 'assets/icons/mood_cemas.png'),
    ('Baik', '15 Mei', 'assets/icons/mood_baik.png'),
    ('Hebat', '14 Mei', 'assets/icons/mood_hebat.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_items.length, (index) {
          final isSelected = index == 0;
          return Padding(
            padding: EdgeInsets.only(right: index < _items.length - 1 ? 12 : 0),
            child: Container(
              width: 82,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(_items[index].$3, width: 36, height: 36, fit: BoxFit.contain),
                  const SizedBox(height: 6),
                  Text(
                    _items[index].$1,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _items[index].$2,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.name, required this.date, required this.session, required this.status, required this.isScheduled});

  final String name;
  final String date;
  final String session;
  final String status;
  final bool isScheduled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://i.pravatar.cc/100?u=${name.replaceAll(' ', '')}',
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.primarySurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 28),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary)),
                const SizedBox(height: 3),
                Text(date, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 1),
                Text(session, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isScheduled
                  ? AppColors.primarySurface.withOpacity(0.55)
                  : AppColors.accentLight.withOpacity(0.70),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: isScheduled ? AppColors.primary : AppColors.accentDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          Icon(icon, size: 24, color: AppColors.textSecondary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textPrimary)),
                const SizedBox(height: 1),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
