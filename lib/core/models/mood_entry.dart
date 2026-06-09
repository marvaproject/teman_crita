class MoodEntry {
  const MoodEntry({
    required this.level,
    required this.label,
    required this.createdAt,
    this.note,
    this.moodName,
    this.iconAsset,
  });

  final int level;
  final String label;
  final String? note;
  final DateTime createdAt;
  final String? moodName;
  final String? iconAsset;

  static const labels = ['Buruk', 'Sedih', 'Biasa', 'Baik', 'Hebat'];

  factory MoodEntry.create({required int level, String? note, String? moodName, String? iconAsset}) {
    if (level < 0 || level > 4) {
      throw ArgumentError.value(level, 'level', 'Mood level must be 0..4');
    }

    final cleanedNote = note?.trim();
    return MoodEntry(
      level: level,
      label: labels[level],
      note: cleanedNote == null || cleanedNote.isEmpty ? null : cleanedNote,
      createdAt: DateTime.now(),
      moodName: moodName,
      iconAsset: iconAsset,
    );
  }
}
