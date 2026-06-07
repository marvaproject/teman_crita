# TemanCrita MVP Revenue Product Spec

## Goal

Build the first mobile MVP path that can demonstrate and later enable revenue: user enters the app, checks mood, gets matched to a psychologist, tries a 10-minute chat, books a session or bundle, and reaches a payment confirmation state.

## MVP User Stories

- As a new user, I can pass onboarding and enter auth so the product value is clear before signup.
- As a signed-in user, I can see a dashboard with mood check-in, upcoming session status, and a clear path to AI matching.
- As a user, I can save one mood level from 0 to 4 without writing a note.
- As a user, I can submit a short story and up to three issue tags to get psychologist recommendations.
- As a user, I can inspect a psychologist profile with specialty, rating, language, price, and slot.
- As a user, I can start a 10-minute trial chat and see the timer at all times.
- As a user, I can move from trial or detail screen into booking.
- As a user, I can choose single session or 3-session bundle, select a payment method, and see success confirmation.

## Acceptance Criteria

- First launch shows onboarding with `Karena Kamu Gak Sendirian`.
- Login/register actions reach the app shell.
- Bottom navigation has Home, Eksplor, Curhat AI, Mood, and Profil.
- Mood selection stores one active mood and updates dashboard copy.
- AI matching rejects empty story and more than three tags.
- Recommendation cards route to psychologist detail.
- Trial chat timer transitions active -> warning -> expired.
- Expired trial dialog routes to booking.
- Booking cannot confirm payment until a method is selected.
- Successful payment produces confirmed booking status and transaction id.

## Out of Scope For This Sprint

- Real Gemini prompt execution.
- Real Midtrans Snap page.
- Push notification scheduling.
- Admin dashboard.
- Landing page.
- Dark mode and custom mascot assets.
