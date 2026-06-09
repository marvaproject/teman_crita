import '../models/matching_request.dart';
import '../models/psychologist.dart';

class DemoRepository {
  const DemoRepository();

  List<Psychologist> get psychologists => const [
        Psychologist(
          id: 'psy-1',
          name: 'Psik. Amanda Putri, M.Psi',
          specialty: 'Cemas, overthinking, hubungan',
          languages: ['Indonesia', 'English'],
          rating: 4.9,
          price: 350000,
          matchReason:
              'Cocok untuk cerita tentang cemas, overthinking, dan kepercayaan diri.',
          availableSlot: 'Hari ini, 10:00',
          bio:
              'Psikolog klinis dengan pendekatan CBT yang hangat, praktis, dan berbasis solusi untuk membantu klien merasa lebih tenang.',
        ),
        Psychologist(
          id: 'psy-2',
          name: 'Psik. Reza Pratama, M.Psi',
          specialty: 'Stres, trauma, pekerjaan',
          languages: ['Indonesia'],
          rating: 4.8,
          price: 300000,
          matchReason:
              'Kuat untuk membantu mengelola stres, tekanan kerja, dan emosi intens.',
          availableSlot: 'Hari ini, 13:00',
          bio:
              'Membantu klien mengelola stres dan tekanan hidup melalui pendekatan CBT dan mindfulness yang terstruktur.',
        ),
        Psychologist(
          id: 'psy-3',
          name: 'Psik. Nadhira Aulia, M.Psi',
          specialty: 'Self love, kecemasan sosial, trauma',
          languages: ['Indonesia'],
          rating: 4.9,
          price: 325000,
          matchReason:
              'Pas untuk cerita tentang self love, kecemasan sosial, dan pemulihan trauma ringan.',
          availableSlot: 'Hari ini, 09:00',
          bio:
              'Pendekatan hangat dan empatik untuk membantu klien menemukan kekuatan dan makna dalam diri.',
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
