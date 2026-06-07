class Psychologist {
  const Psychologist({
    required this.id,
    required this.name,
    required this.specialty,
    required this.languages,
    required this.rating,
    required this.price,
    required this.matchReason,
    required this.availableSlot,
    required this.bio,
  });

  final String id;
  final String name;
  final String specialty;
  final List<String> languages;
  final double rating;
  final int price;
  final String matchReason;
  final String availableSlot;
  final String bio;
}
