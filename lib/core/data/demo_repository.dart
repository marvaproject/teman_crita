import '../models/matching_request.dart';
import '../models/psychologist.dart';

class DemoRepository {
  const DemoRepository();

  List<Psychologist> get psychologists => const [
        Psychologist(
          id: 'psy-1',
          name: 'Dr. Maya Prameswari',
          specialty: 'Kecemasan, stres kerja',
          languages: ['Indonesia', 'English'],
          rating: 4.9,
          price: 150000,
          matchReason: 'Cocok untuk cerita tentang cemas dan tekanan kerja.',
          availableSlot: 'Hari ini, 19.00',
          bio:
              'Psikolog klinis dewasa dengan pendekatan CBT yang hangat dan praktis.',
        ),
        Psychologist(
          id: 'psy-2',
          name: 'Raka Adinata, M.Psi',
          specialty: 'Relasi, keluarga muda',
          languages: ['Indonesia'],
          rating: 4.8,
          price: 175000,
          matchReason: 'Kuat untuk pola komunikasi dan konflik relasi.',
          availableSlot: 'Besok, 10.00',
          bio:
              'Berpengalaman membantu klien memahami pola relasi dan batas sehat.',
        ),
        Psychologist(
          id: 'psy-3',
          name: 'Nadia Salsabila, M.Psi',
          specialty: 'Burnout, tidur, self-esteem',
          languages: ['Indonesia'],
          rating: 4.7,
          price: 125000,
          matchReason: 'Pas untuk keluhan lelah mental dan tidur terganggu.',
          availableSlot: 'Jumat, 16.30',
          bio:
              'Fokus pada regulasi emosi, rutinitas pemulihan, dan journaling.',
        ),
      ];

  List<Psychologist> match(MatchingRequest request) {
    if (!request.isValid) return const [];
    final story = request.story.toLowerCase();
    if (story.contains('relasi') || story.contains('pasangan')) {
      return [psychologists[1], psychologists[0], psychologists[2]];
    }
    if (story.contains('tidur') || story.contains('capek')) {
      return [psychologists[2], psychologists[0], psychologists[1]];
    }
    return psychologists;
  }
}
