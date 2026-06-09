import 'package:flutter/material.dart';

import '../../core/models/psychologist.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/app_snackbar.dart';
import '../../core/widgets/app_card.dart';
import '../../main.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _availableTodayOnly = false;
  String _query = '';
  String _specializationFilter = '';
  String _priceFilter = '';
  String _experienceFilter = '';

  static const _specializations = ['Cemas', 'Stres', 'Trauma', 'Relasi', 'Self Love'];
  static const _priceRanges = [
    '< Rp250.000',
    'Rp250.000 - Rp350.000',
    '> Rp350.000',
  ];
  static const _experienceLevels = ['< 3 tahun', '3 - 5 tahun', '> 5 tahun'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final psychologists = _filteredPsychologists(state.repository.psychologists);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 360;
    final double titleSize = isSmallScreen ? 26.0 : 30.0;
    final double subtitleSize = isSmallScreen ? 13.5 : 15.0;
    final double imageWidth = isSmallScreen ? 96.0 : 124.0;
    final double imageHeight = isSmallScreen ? 76.0 : 98.0;

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
              children: [
                const SizedBox(height: 24.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Eksplor Psikolog',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: titleSize,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            'Temukan psikolog profesional yang paling\nsesuai dengan kebutuhanmu.',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: subtitleSize,
                              fontWeight: FontWeight.w500,
                              height: 1.55,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Image.asset(
                      'assets/illustration/cloud_search_mascot.png',
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => SizedBox(
                        width: imageWidth,
                        height: imageHeight,
                        child: const Icon(
                          Icons.manage_search_rounded,
                          color: AppColors.primaryLight,
                          size: 64.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                _SearchAndFilterRow(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() => _query = value.trim().toLowerCase());
                  },
                ),
                const SizedBox(height: 12.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _FilterChipButton(
                        label: _specializationFilter.isEmpty ? 'Semua Spesialisasi' : _specializationFilter,
                        options: _specializations,
                        selected: _specializationFilter,
                        onSelected: (v) => setState(() => _specializationFilter = v),
                      ),
                      const SizedBox(width: 12.0),
                      _FilterChipButton(
                        label: _priceFilter.isEmpty ? 'Harga' : _priceFilter,
                        options: _priceRanges,
                        selected: _priceFilter,
                        onSelected: (v) => setState(() => _priceFilter = v),
                      ),
                      const SizedBox(width: 12.0),
                      _FilterChipButton(
                        label: _experienceFilter.isEmpty ? 'Pengalaman' : _experienceFilter,
                        options: _experienceLevels,
                        selected: _experienceFilter,
                        onSelected: (v) => setState(() => _experienceFilter = v),
                      ),
                      const SizedBox(width: 12.0),
                      _AvailabilityToggleChip(
                        selected: _availableTodayOnly,
                        onChanged: (value) {
                          setState(() => _availableTodayOnly = value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${psychologists.length} psikolog tersedia',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Urutkan: Terpopuler',
                          style: AppTypography.label.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.primary,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                ...psychologists.map(
                  (psychologist) => _PsychologistExploreCard(
                    psychologist: psychologist,
                    onDetail: () {
                      state.selectPsychologist(psychologist);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PsychologistDetailScreen(),
                        ),
                      );
                    },
                  ),
                ),
                if (psychologists.isEmpty)
                  const _EmptySearchState(),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Psychologist> _filteredPsychologists(List<Psychologist> psychologists) {
    return psychologists.where((psychologist) {
      final searchable = [
        psychologist.name,
        psychologist.specialty,
        psychologist.bio,
        psychologist.languages.join(' '),
      ].join(' ').toLowerCase();
      final matchesQuery = _query.isEmpty || searchable.contains(_query);
      final matchesAvailability =
          !_availableTodayOnly || psychologist.availableSlot.toLowerCase().contains('hari ini');

      final matchesSpecialization = _specializationFilter.isEmpty ||
          psychologist.specialty.toLowerCase().contains(_specializationFilter.toLowerCase());

      final matchesPrice = _priceFilter.isEmpty ||
          switch (_priceFilter) {
            '< Rp250.000' => psychologist.price < 250000,
            'Rp250.000 - Rp350.000' => psychologist.price >= 250000 && psychologist.price <= 350000,
            '> Rp350.000' => psychologist.price > 350000,
            _ => true,
          };

      final years = _experienceYears(psychologist.id);
      final matchesExperience = _experienceFilter.isEmpty ||
          switch (_experienceFilter) {
            '< 3 tahun' => years < 3,
            '3 - 5 tahun' => years >= 3 && years <= 5,
            '> 5 tahun' => years > 5,
            _ => true,
          };

      return matchesQuery && matchesAvailability && matchesSpecialization && matchesPrice && matchesExperience;
    }).toList();
  }

  int _experienceYears(String id) {
    return switch (id) {
      'psy-1' => 6,
      'psy-2' => 5,
      _ => 4,
    };
  }
}

class PsychologistDetailScreen extends StatelessWidget {
  const PsychologistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final psychologist = state.selectedPsychologist ?? state.repository.psychologists.first;
    final detail = _PsychologistViewData.from(psychologist);
    final spacing = context.spacing;

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
                SizedBox(height: spacing.gridGap - 4),
                _BackIconButton(onTap: () => Navigator.of(context).pop()),
                SizedBox(height: spacing.gridGap - 2),
                AppCard.section(
                  padding: EdgeInsets.all(spacing.pagePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: _AvatarWithStatus(
                          asset: detail.asset,
                          size: 118.0,
                          fallbackLabel: detail.initials,
                        ),
                      ),
                      SizedBox(height: spacing.pagePadding - 4),
                      Center(
                        child: _SpecialtyBadge(label: detail.badge),
                      ),
                      SizedBox(height: spacing.gridGap - 2),
                      Text(
                        psychologist.name,
                        style: AppTypography.h1.copyWith(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spacing.gridGap - 8),
                      Center(
                        child: Text(
                          '${detail.experience} pengalaman • ${detail.audience}',
                          style: AppTypography.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: spacing.gridGap + 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.accentDark,
                            size: 22.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '${psychologist.rating} ${detail.reviews}',
                            style: AppTypography.h3.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: spacing.gridGap),
                          Text(
                            _formatPrice(psychologist.price),
                            style: AppTypography.h2.copyWith(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing.pagePadding - 2),
                      Text(
                        'Tentang Psikolog',
                        style: AppTypography.h2.copyWith(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: spacing.gridGap - 6),
                      Text(
                        psychologist.bio,
                        style: AppTypography.body.copyWith(
                          height: 1.55,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: spacing.pagePadding - 4),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: detail.tags.map((tag) => _TagChip(label: tag)).toList(),
                      ),
                      SizedBox(height: spacing.pagePadding - 2),
                      _DetailInfoRow(
                        icon: Icons.translate_rounded,
                        label: 'Bahasa',
                        value: psychologist.languages.join(', '),
                      ),
                      SizedBox(height: spacing.gridGap - 4),
                      _DetailInfoRow(
                        icon: Icons.event_available_rounded,
                        label: 'Slot Terdekat',
                        value: psychologist.availableSlot,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing.gridGap + 2),
                _PrimaryActionButton(
                  label: 'Coba Chat 10 Menit',
                  icon: Icons.chat_bubble_rounded,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const TrialChatScreen()),
                    );
                  },
                ),
                SizedBox(height: spacing.gridGap - 4),
                _OutlineActionButton(
                  label: 'Booking Sesi Penuh',
                  onPressed: () {
                    state.startBooking(bundle: false);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const BookingScreen()),
                    );
                  },
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchAndFilterRow extends StatelessWidget {
  const _SearchAndFilterRow({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final radii = context.radii;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52.0,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTypography.body,
              decoration: InputDecoration(
                hintText: 'Cari nama psikolog, spesialisasi, atau masalah...',
                hintStyle: AppTypography.body.copyWith(
                  color: AppColors.textSecondary.withOpacity(0.72),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textSecondary,
                  size: 22.0,
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: spacing.pagePaddingCompact,
                  vertical: spacing.gridGap,
                ),
                border: _outlineBorder(radii.button),
                enabledBorder: _outlineBorder(radii.button),
                focusedBorder: _outlineBorder(radii.button, color: AppColors.primary, width: 1.4),
              ),
            ),
          ),
        ),
        SizedBox(width: spacing.gridGap),
        SizedBox(
          height: 52.0,
          child: OutlinedButton.icon(
            onPressed: () {
              AppSnackbar.show(context, 'Filter lanjutan belum tersedia');
            },
            icon: const Icon(Icons.filter_alt_outlined, size: 20.0),
            label: const Text('Filter'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              backgroundColor: AppColors.white,
              side: BorderSide(
                color: AppColors.border.withOpacity(0.55),
                width: 1.2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radii.button),
              ),
              padding: EdgeInsets.symmetric(horizontal: spacing.pagePaddingCompact),
              textStyle: AppTypography.label,
            ),
          ),
        ),
      ],
    );
  }
}

OutlineInputBorder _outlineBorder(double radius, {Color? color, double width = 1.2}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(
      color: color ?? AppColors.border.withOpacity(0.55),
      width: width,
    ),
  );
}

class _FilterChipButton extends StatelessWidget {
  const _FilterChipButton({
    required this.label,
    this.options,
    this.selected,
    this.onSelected,
  });

  final String label;
  final List<String>? options;
  final String? selected;
  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final radii = context.radii;
    final hasOptions = options != null && options!.isNotEmpty;

    final chip = Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: spacing.pagePaddingCompact),
      decoration: BoxDecoration(
        color: selected != null && selected!.isNotEmpty ? AppColors.primarySurface : AppColors.white,
        borderRadius: BorderRadius.circular(radii.button),
        border: Border.all(
          color: selected != null && selected!.isNotEmpty
              ? AppColors.primary.withOpacity(0.4)
              : AppColors.border.withOpacity(0.6),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: AppTypography.label.copyWith(
                color: selected != null && selected!.isNotEmpty ? AppColors.primary : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6.0),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: selected != null && selected!.isNotEmpty ? AppColors.primary : AppColors.primary,
            size: 18.0,
          ),
        ],
      ),
    );

    if (!hasOptions) return chip;

    return PopupMenuButton<String>(
      onSelected: onSelected,
      offset: const Offset(0, 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radii.button)),
      child: chip,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: '',
          child: Text('Semua', style: AppTypography.body),
        ),
        ...options!.map((option) => PopupMenuItem(
          value: option,
          child: Row(
            children: [
              Icon(
                option == selected ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 10),
              Text(option, style: AppTypography.body),
            ],
          ),
        )),
      ],
    );
  }
}

class _AvailabilityToggleChip extends StatelessWidget {
  const _AvailabilityToggleChip({
    required this.selected,
    required this.onChanged,
  });

  final bool selected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final radii = context.radii;

    return Container(
      height: 40.0,
      padding: EdgeInsets.only(left: spacing.pagePaddingCompact, right: 8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radii.button),
        border: Border.all(
          color: AppColors.border.withOpacity(0.6),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tersedia Hari Ini',
            style: AppTypography.label.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          Transform.scale(
            scale: 0.72,
            child: Switch(
              value: selected,
              activeColor: AppColors.primary,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _PsychologistExploreCard extends StatelessWidget {
  const _PsychologistExploreCard({
    required this.psychologist,
    required this.onDetail,
  });

  final Psychologist psychologist;
  final VoidCallback onDetail;

  @override
  Widget build(BuildContext context) {
    final detail = _PsychologistViewData.from(psychologist);

    final spacing = context.spacing;

    return AppCard.compact(
      margin: EdgeInsets.only(bottom: spacing.gridGap - 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AvatarWithStatus(
                asset: detail.asset,
                size: 64.0,
                fallbackLabel: detail.initials,
              ),
              SizedBox(width: spacing.gridGap - 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            psychologist.name,
                            style: AppTypography.h3,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        _RatingPill(
                          rating: psychologist.rating,
                        ),
                      ],
                    ),
                    SizedBox(height: spacing.gridGap - 10),
                    Text(
                      '${detail.badge} • ${detail.experience} • ${detail.audience}',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spacing.gridGap - 8),
                    Row(
                      children: [
                        Text(
                          _formatPrice(psychologist.price),
                          style: AppTypography.h3.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          ' / sesi',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spacing.gridGap - 4),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: detail.compactTags.map((tag) => _TagChip(label: tag)).toList(),
          ),
          SizedBox(height: spacing.gridGap - 6),
          Text(
            detail.description,
            style: AppTypography.caption.copyWith(
              height: 1.45,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spacing.gridGap - 4),
          Container(
            padding: EdgeInsets.only(top: spacing.gridGap - 4),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withOpacity(0.55),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _CompactAvailability(slot: psychologist.availableSlot),
                ),
                SizedBox(width: spacing.gridGap - 6),
                _DetailButton(onPressed: onDetail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarWithStatus extends StatelessWidget {
  const _AvatarWithStatus({
    required this.asset,
    required this.size,
    required this.fallbackLabel,
  });

  final String asset;
  final double size;
  final String fallbackLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          ClipOval(
            child: Image.network(
              asset,
              width: size,
              height: size,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: size * 0.4,
                      height: size * 0.4,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  color: AppColors.primarySurface,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    fallbackLabel,
                    style: AppTypography.h2.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 2.0,
            bottom: 0.0,
            child: Container(
              width: 14.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  const _RatingPill({
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: AppColors.accentDark,
            size: 13.0,
          ),
          const SizedBox(width: 2.0),
          Text(
            '$rating',
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialtyBadge extends StatelessWidget {
  const _SpecialtyBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColors.primarySurface.withOpacity(0.78),
        borderRadius: BorderRadius.circular(radii.pill),
      ),
      child: Text(
        label,
        style: AppTypography.label.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: AppColors.primarySurface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(radii.pill),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _CompactAvailability extends StatelessWidget {
  const _CompactAvailability({required this.slot});

  final String slot;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Row(
      children: [
        Container(
          width: 26.0,
          height: 26.0,
          decoration: const BoxDecoration(
            color: AppColors.accentLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.event_available_rounded,
            color: AppColors.accentDark,
            size: 14.0,
          ),
        ),
        SizedBox(width: spacing.iconInline - 6),
        Expanded(
          child: Text(
            slot,
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _DetailButton extends StatelessWidget {
  const _DetailButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;

    return SizedBox(
      height: 48.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radii.pill),
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
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;

    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20.0),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radii.button),
          ),
          textStyle: AppTypography.buttonText,
        ),
      ),
    );
  }
}

class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;

    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radii.button),
          ),
          textStyle: AppTypography.buttonText.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class _BackIconButton extends StatelessWidget {
  const _BackIconButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radii.button),
      child: Container(
        width: 42.0,
        height: 42.0,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(radii.button),
          border: Border.all(color: AppColors.border.withOpacity(0.6)),
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.textPrimary,
          size: 22.0,
        ),
      ),
    );
  }
}

class _DetailInfoRow extends StatelessWidget {
  const _DetailInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Row(
      children: [
        Container(
          width: 38.0,
          height: 38.0,
          decoration: const BoxDecoration(
            color: AppColors.primarySurface,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: spacing.iconDefault),
        ),
        SizedBox(width: spacing.gridGap - 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.caption,
              ),
              const SizedBox(height: 2.0),
              Text(
                value,
                style: AppTypography.label,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return AppCard.section(
      padding: EdgeInsets.all(spacing.pagePadding),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            color: AppColors.primary,
            size: 42.0,
          ),
          SizedBox(height: spacing.gridGap - 4),
          Text(
            'Tidak ada psikolog yang cocok',
            style: AppTypography.h3,
          ),
          SizedBox(height: spacing.gridGap - 10),
          Text(
            'Coba ubah kata kunci atau matikan filter ketersediaan.',
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PsychologistViewData {
  const _PsychologistViewData({
    required this.asset,
    required this.initials,
    required this.badge,
    required this.experience,
    required this.audience,
    required this.reviews,
    required this.tags,
    required this.description,
  });

  final String asset;
  final String initials;
  final String badge;
  final String experience;
  final String audience;
  final String reviews;
  final List<String> tags;
  final String description;

  List<String> get previewTags {
    if (tags.length <= 5) return tags;
    return [...tags.take(4), '+${tags.length - 4}'];
  }

  List<String> get compactTags {
    if (tags.length <= 4) return tags;
    return [...tags.take(3), '+${tags.length - 3}'];
  }

  static _PsychologistViewData from(Psychologist psychologist) {
    switch (psychologist.id) {
      case 'psy-1':
        return const _PsychologistViewData(
          asset: 'https://i.pravatar.cc/150?u=psy-1',
          initials: 'AP',
          badge: 'Psikolog Klinis',
          experience: '6 tahun',
          audience: 'Remaja, Dewasa',
          reviews: '(128)',
          tags: ['Cemas', 'Overthinking', 'Hubungan', 'Kepercayaan Diri', 'CBT', 'Self Care'],
          description:
              'Berfokus pada terapi kognitif dan pendekatan berbasis solusi untuk membantu Anda merasa lebih baik.',
        );
      case 'psy-2':
        return const _PsychologistViewData(
          asset: 'https://i.pravatar.cc/150?u=psy-2',
          initials: 'RP',
          badge: 'Psikolog Klinis',
          experience: '5 tahun',
          audience: 'Dewasa, Remaja',
          reviews: '(96)',
          tags: ['Stres', 'Trauma', 'Pekerjaan', 'Manajemen Emosi', 'Mindfulness'],
          description:
              'Membantu klien mengelola stres dan tekanan hidup melalui pendekatan CBT dan mindfulness.',
        );
      default:
        return const _PsychologistViewData(
          asset: 'https://i.pravatar.cc/150?u=psy-3',
          initials: 'NA',
          badge: 'Psikolog Klinis',
          experience: '4 tahun',
          audience: 'Dewasa, Remaja',
          reviews: '(74)',
          tags: ['Self Love', 'Kecemasan Sosial', 'Depresi Ringan', 'Trauma', 'Relasi'],
          description:
              'Pendekatan hangat dan empatik untuk membantu Anda menemukan kekuatan dan makna dalam diri.',
        );
    }
  }
}

String _formatPrice(int price) {
  final raw = price.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < raw.length; i++) {
    final indexFromEnd = raw.length - i;
    buffer.write(raw[i]);
    if (indexFromEnd > 1 && indexFromEnd % 3 == 1) {
      buffer.write('.');
    }
  }
  return 'Rp$buffer';
}
