# TemanCrita MVP API Contracts

## Supabase Tables

Use `docs/Prototype/TemanCrita Supabase Schema.sql` as the database contract. MVP screens depend on:

- `profiles`: user identity and role.
- `mood_entries`: daily mood logs.
- `psychologists`: public psychologist profile, price, language, and rating.
- `bookings`: booking type, amount, payment method, payment status, booking status, provider references.
- `sessions`: confirmed consultation schedule.
- `trial_chats`: 10-minute trial session state.

## Edge Function: Create Payment

Endpoint: `create-payment`

Request:

```json
{
  "booking_id": "uuid",
  "payment_method": "qris",
  "amount": 150000
}
```

Response:

```json
{
  "transaction_id": "provider-transaction-id",
  "provider_ref": "midtrans-order-id",
  "redirect_url": "https://payment.example/...",
  "payment_status": "pending"
}
```

## Edge Function: Payment Webhook

Midtrans calls the webhook. The function validates signature, updates `bookings.payment_status`, and sets `bookings.booking_status` to `confirmed` when payment succeeds.

## Client Rules

- Flutter sends only user-safe data.
- Flutter never stores Midtrans server keys.
- Flutter treats Supabase booking status as the final source of truth.
