enum BookingType { single, bundle }

enum PaymentMethod { qris, virtualAccount, gopay }

enum PaymentStatus { unpaid, pending, success, failed, expired }

enum BookingStatus { draft, pendingPayment, confirmed, canceled, expired }

class BookingDraft {
  const BookingDraft({
    required this.psychologistId,
    required this.slotLabel,
    required this.amount,
    required this.bookingType,
    required this.sessionCount,
    this.paymentMethod,
    this.paymentStatus = PaymentStatus.unpaid,
    this.bookingStatus = BookingStatus.draft,
    this.transactionId,
  });

  final String psychologistId;
  final String slotLabel;
  final int amount;
  final BookingType bookingType;
  final int sessionCount;
  final PaymentMethod? paymentMethod;
  final PaymentStatus paymentStatus;
  final BookingStatus bookingStatus;
  final String? transactionId;

  factory BookingDraft.single({
    required String psychologistId,
    required String slotLabel,
    required int amount,
  }) {
    return BookingDraft(
      psychologistId: psychologistId,
      slotLabel: slotLabel,
      amount: amount,
      bookingType: BookingType.single,
      sessionCount: 1,
    );
  }

  factory BookingDraft.bundle({
    required String psychologistId,
    required String slotLabel,
    required int amount,
  }) {
    return BookingDraft(
      psychologistId: psychologistId,
      slotLabel: slotLabel,
      amount: amount,
      bookingType: BookingType.bundle,
      sessionCount: 3,
    );
  }

  BookingDraft selectPaymentMethod(PaymentMethod method) {
    return copyWith(
      paymentMethod: method,
      paymentStatus: PaymentStatus.pending,
      bookingStatus: BookingStatus.pendingPayment,
    );
  }

  BookingDraft markPaymentSuccess({required String transactionId}) {
    return copyWith(
      paymentStatus: PaymentStatus.success,
      bookingStatus: BookingStatus.confirmed,
      transactionId: transactionId,
    );
  }

  BookingDraft markPaymentFailed() {
    return copyWith(paymentStatus: PaymentStatus.failed);
  }

  BookingDraft copyWith({
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    BookingStatus? bookingStatus,
    String? transactionId,
  }) {
    return BookingDraft(
      psychologistId: psychologistId,
      slotLabel: slotLabel,
      amount: amount,
      bookingType: bookingType,
      sessionCount: sessionCount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      transactionId: transactionId ?? this.transactionId,
    );
  }
}
