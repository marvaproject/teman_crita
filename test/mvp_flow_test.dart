import 'package:flutter_test/flutter_test.dart';
import 'package:teman_crita/core/models/mood_entry.dart';
import 'package:teman_crita/core/models/booking.dart';
import 'package:teman_crita/core/models/matching_request.dart';
import 'package:teman_crita/core/models/trial_session.dart';

void main() {
  group('MoodEntry', () {
    test('accepts a mood level from 0 to 4 with an optional note', () {
      final entry = MoodEntry.create(level: 4, note: '');

      expect(entry.level, 4);
      expect(entry.label, 'Hebat');
      expect(entry.note, isNull);
    });

    test('rejects mood levels outside the app scale', () {
      expect(
        () => MoodEntry.create(level: 5, note: 'too high'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('MatchingRequest', () {
    test('requires a non-empty story and allows at most three tags', () {
      const request = MatchingRequest(
        story: 'Aku lagi sering cemas di tempat kerja.',
        issueTags: ['cemas', 'kerja', 'tidur'],
      );

      expect(request.isValid, isTrue);
    });

    test('marks more than three tags as invalid', () {
      const request = MatchingRequest(
        story: 'Aku butuh bantuan.',
        issueTags: ['cemas', 'kerja', 'tidur', 'relasi'],
      );

      expect(request.isValid, isFalse);
    });
  });

  group('BookingDraft', () {
    test('moves from draft to pending payment when method is selected', () {
      final draft = BookingDraft.single(
        psychologistId: 'psy-1',
        slotLabel: 'Hari ini, 19.00',
        amount: 150000,
      );

      final pending = draft.selectPaymentMethod(PaymentMethod.qris);

      expect(pending.paymentMethod, PaymentMethod.qris);
      expect(pending.paymentStatus, PaymentStatus.pending);
      expect(pending.bookingStatus, BookingStatus.pendingPayment);
    });

    test('marks booking as confirmed after successful payment', () {
      final booking = BookingDraft.single(
        psychologistId: 'psy-1',
        slotLabel: 'Besok, 10.00',
        amount: 150000,
      ).selectPaymentMethod(PaymentMethod.virtualAccount).markPaymentSuccess(
            transactionId: 'trx-123',
          );

      expect(booking.paymentStatus, PaymentStatus.success);
      expect(booking.bookingStatus, BookingStatus.confirmed);
      expect(booking.transactionId, 'trx-123');
    });
  });

  group('TrialSession', () {
    test('reports warning below two minutes and expired at zero seconds', () {
      expect(const TrialSession(remainingSeconds: 600).state, TrialState.active);
      expect(const TrialSession(remainingSeconds: 119).state, TrialState.warning);
      expect(const TrialSession(remainingSeconds: 0).state, TrialState.expired);
    });
  });
}
