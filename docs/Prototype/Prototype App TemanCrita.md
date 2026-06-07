# Teman Crita — Prototype App Specification

Dokumen ini adalah acuan prototype untuk **Flutter app user-facing** Teman Crita saja.

- Fokus: pengalaman pengguna di mobile app
- Di luar scope: landing page, admin dashboard, dan komponen backend
- Referensi sistem keseluruhan: `SYSTEM.md`
- Referensi monetisasi dan prioritas bisnis: `BUSINESS-SYSTEM.md`

## 1. Ringkasan Produk

Teman Crita adalah platform kesehatan mental hybrid yang menghubungkan pengguna dengan psikolog tersertifikasi melalui AI matching cerdas, mood tracking harian, dan sesi percobaan gratis.

Target utama produk:
- Pekerja muda usia 18-35 tahun
- Mahasiswa 18-24 tahun sebagai target sekunder
- Orang tua muda 30-45 tahun dan B2B corporate sebagai target lanjutan

Tagline utama:
- `Karena Kamu Gak Sendirian`

## 2. Brand Identity

### 2.1 Value Proposition

Teman Crita adalah platform kesehatan mental hybrid (online dan offline) yang menghubungkan pengguna dengan psikolog tersertifikasi melalui AI matching cerdas, mood tracking harian, dan sesi percobaan gratis.

### 2.2 Brand Personality

- Hangat
- Terpercaya
- Modern
- Empatik

### 2.3 Tone of Voice

Casual-akrab, seperti ngobrol sama teman dekat yang supportive.

Contoh:
- `Gak usah dipendam sendiri. Cerita aja ke kita.`

### 2.4 Target Audiens

- Primary: pekerja muda 18-35 tahun, urban, melek teknologi
- Secondary: mahasiswa 18-24 tahun
- Tersier: orang tua muda 30-45 tahun dan B2B corporate pada tahap lanjutan

## 3. Visual Identity

### 3.1 Color Palette

Palet utama mengikuti `design-brief.md` dan harus dipakai konsisten di seluruh app.

| Token | Hex | Penggunaan |
| --- | --- | --- |
| `primary` | `#4338CA` | CTA, header aktif, primary buttons |
| `primaryLight` | `#6C63FF` | Hover, disabled state |
| `primaryDark` | `#3730A3` | Teks pada background terang, depth |
| `primarySurface` | `#EEF2FF` | Card background ringan, highlight |
| `accent` | `#F5C06A` | Rating stars, badges, aksen hangat |
| `accentLight` | `#FDF3E0` | Star rating bg, chip bg |
| `accentDark` | `#E5A845` | Teks pada accent elements |
| `background` | `#FFFFFF` | Screen background |
| `surface` | `#F5F7F8` | Card alternate bg, divider area |
| `card` | `#FFFFFF` | Card utama |
| `border` | `#E5E7EB` | Card border 1px, dividers |
| `textPrimary` | `#1A1A2E` | Judul, teks utama |
| `textSecondary` | `#6B7280` | Body teks |
| `textMuted` | `#9CA3AF` | Caption, hint |

### 3.2 Mood and Semantic Colors

| Token | Hex | Penggunaan |
| --- | --- | --- |
| `moodHappy` | `#A3E635` | Mood "Hebat" |
| `moodGood` | `#66BB9A` | Mood "Baik" |
| `moodNeutral` | `#F5C06A` | Mood "Biasa" |
| `moodSad` | `#94A3B8` | Mood "Sedih" |
| `moodBad` | `#E85D5D` | Mood "Buruk" |
| `moodCalm` | `#D4C5F9` | Sleep/Tidur quick action |
| `error` | `#E85D5D` | Validation, error |
| `success` | `#10B981` | Online status, success |
| `warning` | `#F5E6A3` | Warning |

### 3.3 Dark Mode

Dark mode masih disiapkan sebagai ruang pengembangan di tahap berikutnya.

| Token | Hex |
| --- | --- |
| `darkBackground` | `#0F172A` |
| `darkCard` | `#1E293B` |
| `darkSurface` | `#1E293B` |
| `darkBorder` | `#334155` |
| `darkTextPrimary` | `#F1F5F9` |
| `darkTextSecondary` | `#94A3B8` |
| `darkTextMuted` | `#64748B` |

### 3.4 Typography

**Primary Font:** Plus Jakarta Sans  
**Fallback:** System sans-serif

| Level | Size | Weight | Color |
| --- | --- | --- | --- |
| `h1` | 28px | Bold 700 | `textPrimary` |
| `h2` | 20px | SemiBold 600 | `textPrimary` |
| `h3` | 16px | SemiBold 600 | `textPrimary` |
| `body` | 14px | Regular 400 | `textSecondary` |
| `caption` | 12px | Medium 500 | `textMuted` |
| `label` | 13px | SemiBold 600 | `textPrimary` |
| `btnText` | 15px | SemiBold 600 | White |

### 3.5 Shape and Spacing

| Token | Value |
| --- | --- |
| Card radius | 16px |
| Button radius | 14px |
| Chip/pill radius | 24px |
| Bottom sheet radius | 24px (top) |
| Horizontal padding | 24px default, 16px (<380px) |
| Card vertical padding | 16-20px |
| Icon button | 40px container, 18px icon |
| Grid gap | 12-16px |
| Card style | Flat, 1px border solid `border`, no shadow |

### 3.6 Iconography

- Icon set: MingCute
- Style: outline, stroke konsisten
- Size: 18-20px default, 14px inline, 24px section

### 3.7 Mascot: Citta si Awan Cerita

**Konsep:** awan putih atau indigo muda dengan wajah minimalis.

| Mood | Ekspresi Citta | Visual |
| --- | --- | --- |
| Hebat (4) | Citta cerah + sinar matahari | Happy, glow |
| Baik (3) | Citta senyum biasa | Smiling |
| Biasa (2) | Citta datar, tanpa senyum | Neutral |
| Sedih (1) | Citta kelabu, sedikit murung | Greyish, frown |
| Buruk (0) | Citta hujan gerimis | Rain drop, sad eyes |

Penggunaan:
- Mood check-in header
- Empty state illustration
- Loading screen `AI sedang menganalisa...`
- Streak / achievement illustration

## 4. Design Guidelines

### 4.1 Layout Principles

- Banyak white space dengan padding konsisten 24px
- Card-based layout dengan border 1px dan flat design
- Informasi dikelompokkan dalam card yang jelas
- Hierarki visual: heading → subheading → body → caption

### 4.2 Mood Hari Ini Component

- Mood selection memakai pill/chip button, bukan circle
- Header icon dinamis menggunakan Citta atau mood icon
- Supportive message dinamis di bawah pills
- Transisi state memakai `AnimatedContainer` 250ms, `easeOutCubic`

### 4.3 Component Helpers

Semua komponen reusable mengikuti `app_colors.dart`:
- `cardDeco()` untuk BoxDecoration flat + border
- `hPad(context)` untuk responsive horizontal padding
- Typography helpers: `h1()`, `h2()`, `h3()`, `body()`, `caption()`, `label()`, `btnText()`

## 5. Prototype Scope

### 5.1 Core Screens

Prototype awal difokuskan pada layar-layar inti berikut untuk pengguna mobile:

1. Onboarding
2. Login dan register
3. Dashboard utama
4. Mood check-in
5. AI matching input
6. Hasil matching
7. Detail psikolog
8. Trial chat 10 menit
9. Booking flow ke sesi penuh
10. Profil
11. Settings
12. Breathing Exercise
13. Guided Journaling
14. Daily Affirmation
15. AI Companion Chat
16. Crisis Resource Center

### 5.2 Product Behavior

- Mood tracking harian menjadi elemen utama di home
- AI matching harus terasa ringan dan suportif, bukan klinis
- Trial chat 10 menit gratis diposisikan sebagai entry point utama
- Online dan offline tetap satu pengalaman yang konsisten secara visual
- Flow booking harus jelas dari detail psikolog menuju pembayaran atau handoff yang dijelaskan di sistem

### 5.3 Out of Scope

Bagian berikut tidak dibahas dalam dokumen prototype ini karena berada di level sistem atau bisnis:

- Landing page web
- Admin dashboard
- Revenue model dan pricing detail
- Kampus partnership dan strategi penjualan
- Fitur komunitas jika belum diprioritaskan di roadmap produk

## Auth Flow

Section ini menjelaskan alur masuk, keluar, dan pemulihan akun agar pengguna selalu diarahkan ke state yang benar.

### Auth Goals

- User lama langsung masuk ke dashboard jika session masih valid.
- User baru melihat onboarding hanya sekali.
- User bisa login, register, verifikasi, reset password, dan logout tanpa kebingungan.
- Error auth harus jelas dan tidak memutus alur terlalu jauh.

### Auth Screens

- Splash / Session Gate
- Onboarding
- Login
- Register
- Email Verification
- Forgot Password
- Reset Password Success
- Session Expired

### Auth Rules

- Jika `first launch`, tampilkan onboarding.
- Jika session valid, langsung arahkan ke dashboard.
- Jika session expired atau invalid, arahkan ke login.
- Jika user menekan skip onboarding, lanjut ke login.
- Setelah register berhasil, arahkan ke verifikasi email jika fitur itu aktif.
- Setelah reset password berhasil, arahkan ke login.
- Setelah logout, arahkan ke login dan bersihkan session lokal.

### Auth Error States

- Email tidak valid
- Password salah
- Akun belum diverifikasi
- Akun sudah terdaftar
- Session expired
- Jaringan bermasalah

### Auth Return Paths

- Login sukses -> Dashboard
- Register sukses -> Email Verification atau Dashboard
- Verification sukses -> Dashboard
- Forgot password sukses -> Reset Password Success
- Logout sukses -> Login
- Session expired -> Login

## Session Flow

Section ini menjelaskan alur sesi konseling dari booking sampai aftercare agar layanan terasa utuh, bukan hanya sekadar transaksi.

### Session Goals

- User bisa melihat sesi yang akan datang dengan jelas.
- User bisa masuk ke sesi tepat waktu tanpa bingung.
- User bisa melakukan reschedule atau cancel dengan aturan yang jelas.
- Setelah sesi selesai, user menerima ringkasan dan langkah lanjut.

### Session Screens

- Session Card di dashboard
- Booking Flow
- Upcoming Session Detail
- Session Reminder / Alert
- Session Join
- Session Summary / Aftercare
- Reschedule / Cancel confirmation

### Session Rules

- Jika ada sesi mendatang, tampilkan di dashboard sebagai prioritas utama setelah mood check-in.
- Jika waktu sesi mendekat, tampilkan reminder sebelum user perlu mencari manual.
- Jika user menekan join, arahkan langsung ke link sesi atau join screen.
- Jika user batal, tampilkan alasan cancel dan konsekuensi jika ada.
- Jika sesi selesai, tampilkan ringkasan singkat dan next action.

### Session States

- Upcoming
- Reminder sent
- Ready to join
- In session
- Completed
- Rescheduled
- Canceled
- No-show

### Session Return Paths

- Upcoming session -> Join session
- Join session -> In session
- In session -> Completed
- Completed -> Session summary / aftercare
- Cancelled / rescheduled -> Dashboard or updated session detail

### Session Data

- `session_id`
- `user_id`
- `psychologist_id`
- `session_type`
- `session_date`
- `session_time`
- `status`
- `join_link`
- `reminder_status`
- `summary_note`
- `homework_note`

## Payment Flow

Section ini menjelaskan alur pembayaran sesi agar booking benar-benar bisa berubah menjadi revenue yang tercatat jelas.

### Payment Goals

- User bisa memilih metode pembayaran dengan mudah.
- Status pembayaran selalu jelas: pending, success, failed, atau expired.
- User tahu apakah booking sudah aktif atau masih menunggu pembayaran.
- Bukti pembayaran dan status transaksi bisa dilacak.

### Payment Screens

- Booking Flow
- Payment Method Selection
- Payment Processing
- Payment Success
- Payment Failed
- Payment Pending
- Receipt / Transaction Detail

### Payment Rules

- Jika user belum memilih metode bayar, jangan lanjut ke transaksi.
- Jika pembayaran pending, tampilkan status menunggu dengan instruksi yang jelas.
- Jika pembayaran gagal, berikan retry dan alternatif metode.
- Jika pembayaran sukses, arahkan user ke sesi atau confirmation screen.
- Jika payment expired, user harus bisa mulai lagi tanpa kehilangan pilihan sesi yang sudah dipilih.

### Payment States

- Unpaid
- Method selected
- Processing
- Pending
- Success
- Failed
- Expired
- Refunded

### Payment Return Paths

- Booking -> Payment Method Selection -> Processing
- Processing -> Success -> Session confirmation
- Processing -> Failed -> Retry / method change
- Pending -> Wait / refresh -> Success or Failed
- Expired -> Booking flow or payment restart

### Payment Data

- `booking_id`
- `session_id`
- `user_id`
- `amount`
- `payment_method`
- `payment_status`
- `transaction_id`
- `provider_ref`
- `receipt_url`
- `created_at`

## Notification Flow

Section ini menjelaskan alur notifikasi agar reminder, follow-up, dan alert berjalan konsisten tanpa mengganggu user berlebihan.

### Notification Goals

- User menerima reminder yang relevan dan tepat waktu.
- Reminder sesi, mood check-in, journaling, dan follow-up tampil jelas.
- Notifikasi krisis harus lebih prioritas daripada notifikasi biasa.
- User bisa mengatur jenis notifikasi yang ingin diterima.

### Notification Types

- Mood check-in reminder
- Session reminder
- Payment reminder
- Follow-up reminder
- Daily affirmation reminder
- Guided journaling reminder
- Crisis alert

### Notification Rules

- Notifikasi harus mengikuti preferensi user.
- Notifikasi sesi harus dikirim sebelum waktu sesi dimulai.
- Notifikasi follow-up harus muncul setelah sesi selesai.
- Notifikasi crisis harus tetap muncul walau reminder lain dimatikan jika itu bagian dari safety rule.
- Jika user menonaktifkan kategori tertentu, hanya kategori itu yang berhenti.

### Notification States

- Enabled
- Disabled
- Scheduled
- Sent
- Delivered
- Read
- Dismissed

### Notification Return Paths

- Notification tap -> Relevant screen
- Dismiss -> Stay on current screen or return to dashboard
- Crisis alert -> Crisis Resource Center
- Session reminder -> Session detail / join flow
- Payment reminder -> Booking / payment flow

### Notification Data

- `notification_id`
- `user_id`
- `notification_type`
- `title`
- `body`
- `target_screen`
- `schedule_time`
- `status`
- `priority`
- `read_at`

## 6. Screen Dictionary

Bagian ini mendefinisikan setiap layar utama agar developer punya acuan yang konsisten.

### 6.1 Onboarding

- **Tujuan:** mengenalkan value app secara singkat dan membangun rasa aman.
- **Isi utama:** hero ilustrasi, headline, 2-3 poin manfaat, CTA utama.
- **CTA utama:** `Mulai Sekarang`
- **CTA sekunder:** `Masuk`
- **State penting:** first launch, skip onboarding, onboarding selesai.
- **Data yang dipakai:** onboarding_step, seen_onboarding, locale.
- **Komponen utama:** hero illustration, step indicator, benefit cards, CTA bar.
- **Masuk dari:** app launch pertama.
- **Keluar ke:** login/register atau dashboard jika sudah pernah selesai.

### 6.2 Login dan Register

- **Tujuan:** autentikasi pengguna.
- **Isi utama:** form email, password, tombol login, opsi Google sign-in.
- **CTA utama:** `Masuk` atau `Daftar`
- **CTA sekunder:** `Lupa Password`
- **State penting:** loading, invalid credential, success redirect.
- **Data yang dipakai:** email, password, auth_provider, session_status.
- **Komponen utama:** input field, helper text, password toggle, sign-in buttons.
- **Masuk dari:** onboarding, session expired, manual access.
- **Keluar ke:** dashboard setelah autentikasi sukses.

### 6.3 Dashboard Utama

- **Tujuan:** menjadi home utama app.
- **Isi utama:** greeting, mood summary, quick actions, upcoming session, reflection card.
- **CTA utama:** `Mulai Cerita` atau `Check-in Mood`
- **CTA sekunder:** akses psikolog, sesi, dan profile.
- **State penting:** data tersedia, belum ada aktivitas, skeleton loading.
- **Data yang dipakai:** user_name, avatar, today_mood, streak_count, next_session, reflection_text.
- **Komponen utama:** app bar, mood summary card, quick action row, upcoming session card, reflection card.
- **Masuk dari:** login/register, back navigation dari fitur lain.
- **Keluar ke:** mood check-in, AI matching, detail psikolog, breathing exercise, journaling, affirmation, companion chat, profile.

### 6.4 Mood Check-in

- **Tujuan:** mencatat kondisi emosi harian.
- **Isi utama:** pilihan mood berbentuk chip, pesan suportif dinamis, catatan singkat opsional.
- **CTA utama:** `Simpan Mood`
- **CTA sekunder:** `Lewati`
- **State penting:** mood belum dipilih, mood dipilih, mood tersimpan.
- **Data yang dipakai:** mood_level, mood_label, mood_note, created_at.
- **Komponen utama:** mood chip group, supportive message, optional note field, save button.
- **Masuk dari:** dashboard.
- **Keluar ke:** dashboard dengan state mood tersimpan.

### 6.5 AI Matching Input

- **Tujuan:** mengumpulkan curhatan dan preferensi pengguna.
- **Isi utama:** text input, kategori masalah, preferensi bahasa/lokasi bila perlu.
- **CTA utama:** `Temukan Psikolog Untukku`
- **CTA sekunder:** `Batal`
- **State penting:** input kosong, input valid, loading analisis.
- **Data yang dipakai:** curhatan_text, issue_tags, language_pref, location_pref.
- **Komponen utama:** multiline input, category chips, helper hint, submit button.
- **Masuk dari:** dashboard, quick action, companion chat escalation.
- **Keluar ke:** hasil matching atau kembali ke dashboard.

### 6.6 Hasil Matching

- **Tujuan:** menampilkan rekomendasi psikolog yang cocok.
- **Isi utama:** 3 kartu rekomendasi, ringkasan alasan matching, aksi ke detail.
- **CTA utama:** `Lihat Detail`
- **CTA sekunder:** `Coba Lagi`
- **State penting:** loading scan, result available, empty result.
- **Data yang dipakai:** recommended_psychologists, match_reason, confidence_level.
- **Komponen utama:** result cards, score badge, scanning state, retry action.
- **Masuk dari:** AI matching input.
- **Keluar ke:** detail psikolog atau ulang input.

### 6.7 Detail Psikolog

- **Tujuan:** memberi informasi untuk keputusan booking.
- **Isi utama:** profil, spesialisasi, rating, harga, bahasa, jadwal, CTA booking.
- **CTA utama:** `Coba Chat 10 Menit` / `Booking Sesi`
- **CTA sekunder:** `Simpan`
- **State penting:** available slot, out of slot, premium/locked jika nanti ada.
- **Data yang dipakai:** psychologist_name, specialty, languages, price, rating, availability, bio, session_type.
- **Komponen utama:** profile header, rating block, session info card, schedule list, primary CTA bar.
- **Masuk dari:** hasil matching atau list eksplorasi.
- **Keluar ke:** trial chat, booking flow, atau kembali ke hasil matching.

### 6.8 Trial Chat

- **Tujuan:** memberi pengalaman ngobrol awal selama 10 menit.
- **Isi utama:** timer, area chat, status sesi, tombol keluar.
- **CTA utama:** `Lanjutkan`
- **CTA sekunder:** `Akhiri`
- **State penting:** active, nearing timeout, expired.
- **Data yang dipakai:** chat_session_id, timer_remaining, message_list, session_status.
- **Komponen utama:** header timer, chat bubbles, quick replies, input bar, timeout dialog.
- **Masuk dari:** detail psikolog.
- **Keluar ke:** booking flow saat trial selesai atau kembali ke detail psikolog.

### 6.9 Booking Flow

- **Tujuan:** membawa user dari minat ke sesi berbayar.
- **Isi utama:** ringkasan pilihan sesi, jadwal, harga, metode pembayaran atau handoff.
- **CTA utama:** `Bayar Sekarang`
- **CTA sekunder:** `Ubah Jadwal`
- **State penting:** selected slot, payment pending, success, failed.
- **Data yang dipakai:** session_type, slot_time, price, payment_method, booking_status.
- **Komponen utama:** summary card, pricing block, payment method list, confirmation CTA, error state.
- **Masuk dari:** detail psikolog atau trial ended upsell.
- **Keluar ke:** confirmation screen atau back ke detail psikolog.

### 6.10 Profil

- **Tujuan:** menyimpan identitas dasar dan ringkasan aktivitas user.
- **Isi utama:** data profil, riwayat mood, riwayat sesi.
- **CTA utama:** `Edit Profil`
- **CTA sekunder:** `Keluar`
- **State penting:** read-only, edit mode, save success.
- **Data yang dipakai:** name, avatar, email, history_links.
- **Komponen utama:** profile card, history shortcuts, summary stats, edit button.
- **Masuk dari:** bottom navigation.
- **Keluar ke:** settings, edit profile state, logout, atau kembali ke dashboard.

### 6.11 Settings

- **Tujuan:** mengatur preferensi aplikasi dan akun.
- **Isi utama:** pengaturan notifikasi, privasi, bahasa, mode tampilan, akun.
- **CTA utama:** `Simpan Pengaturan`
- **CTA sekunder:** `Kembali`
- **State penting:** default, changed, saved.
- **Data yang dipakai:** notification_pref, privacy_pref, language_pref, theme_pref.
- **Komponen utama:** settings list, toggle rows, language selector, save button.
- **Masuk dari:** profil.
- **Keluar ke:** profil atau dashboard setelah save.

### 6.12 Breathing Exercise

- **Tujuan:** membantu user menenangkan diri saat cemas atau kewalahan.
- **Isi utama:** animasi napas, pilihan pola napas, timer, instruksi singkat.
- **CTA utama:** `Mulai`
- **CTA sekunder:** `Ganti Pola`
- **State penting:** idle, active, completed.
- **Data yang dipakai:** breathing_pattern, duration_seconds, completion_status.
- **Komponen utama:** animated circle or soft shape, pattern selector, timer text, completion card.
- **Masuk dari:** dashboard, crisis resource center, companion chat suggestion.
- **Keluar ke:** guided journaling, daily affirmation, atau dashboard.

### 6.13 Guided Journaling

- **Tujuan:** memudahkan user mulai menulis tanpa bingung harus dari mana.
- **Isi utama:** prompt jurnal, input teks, pilihan tema, simpan draft.
- **CTA utama:** `Simpan Jurnal`
- **CTA sekunder:** `Ganti Prompt`
- **State penting:** empty, typing, saved.
- **Data yang dipakai:** prompt_text, journal_content, tags, saved_at, draft_status.
- **Komponen utama:** prompt card, text area, theme chips, draft state, save bar.
- **Masuk dari:** dashboard, breathing exercise, companion chat suggestion.
- **Keluar ke:** saved journal view atau kembali ke dashboard.

### 6.14 Daily Affirmation

- **Tujuan:** memberi dorongan emosional singkat setiap hari.
- **Isi utama:** kartu afirmasi, tombol refresh, favorit.
- **CTA utama:** `Simpan ke Favorit`
- **CTA sekunder:** `Ganti Afirmasi`
- **State penting:** default, personalized, saved.
- **Data yang dipakai:** affirmation_text, mood_tag, favorite_status, generated_at.
- **Komponen utama:** affirmation card, favorite toggle, refresh button, share option jika diperlukan.
- **Masuk dari:** dashboard, after journaling, after breathing.
- **Keluar ke:** save success state atau kembali ke dashboard.

### 6.15 AI Companion Chat

- **Tujuan:** memberi ruang refleksi ringan bersama Citta, bukan terapi klinis.
- **Isi utama:** chat bubble, quick reply, mood-aware response, suggested next action.
- **CTA utama:** `Kirim`
- **CTA sekunder:** `Pertanyaan Baru`
- **State penting:** idle, typing, response ready, escalation suggestion.
- **Data yang dipakai:** user_message, bot_reply, quick_replies, escalation_flag, mood_context.
- **Komponen utama:** chat stream, typing indicator, quick reply chips, suggestion card.
- **Masuk dari:** dashboard atau companion prompt.
- **Keluar ke:** breathing exercise, journaling, crisis resource center, atau matching input.

### 6.16 Crisis Resource Center

- **Tujuan:** menyediakan jalur bantuan cepat saat user merasa sangat tertekan.
- **Isi utama:** hotline, tombol bantuan cepat, resource list, arahan singkat.
- **CTA utama:** `Hubungi Bantuan`
- **CTA sekunder:** `Hubungi Psikolog`
- **State penting:** normal, alert, emergency.
- **Data yang dipakai:** urgency_level, hotline_list, resource_links, recommended_action.
- **Komponen utama:** alert banner, hotline cards, emergency CTA, resource list.
- **Masuk dari:** companion chat escalation, distress detection, manual access.
- **Keluar ke:** call action, chat with psychologist, or emergency instructions.

## 7. Component Dictionary

Komponen berikut adalah blok reusable yang harus dipakai konsisten.

### 7.1 App Bar

- **Fungsi:** header layar.
- **Variasi:** normal, compact, with action, with back button.
- **Anatomi:** title, leading icon, trailing action, optional subtitle.
- **State:** default, scrolled, with unread badge.
- **Data yang dipakai:** page_title, back_enabled, action_icon, action_state.
- **Aturan pakai:** gunakan untuk judul halaman dan navigasi kembali. Hindari terlalu banyak action dalam satu app bar.

### 7.2 Bottom Navigation

- **Fungsi:** navigasi utama app.
- **Variasi:** 5 tab tetap.
- **Anatomi:** tab icon, tab label, active indicator, central emphasis pada aksi utama jika dibutuhkan.
- **State:** active, inactive, disabled, notification badge.
- **Data yang dipakai:** tab_id, label, icon, active_route, badge_count.
- **Aturan pakai:** jangan ditambah tab tanpa perubahan arsitektur. Jumlah tab harus tetap stabil agar navigasi konsisten.

### 7.3 Mood Chip

- **Fungsi:** memilih mood.
- **Variasi:** default, selected, disabled.
- **Anatomi:** icon kecil, label mood, optional score atau subtitle.
- **State:** default, selected, disabled, pressed.
- **Data yang dipakai:** mood_id, mood_label, mood_icon, mood_color.
- **Aturan pakai:** gunakan pill/chip, bukan bulat penuh. Satu pilihan aktif saja pada satu waktu.

### 7.4 Psychologist Card

- **Fungsi:** menampilkan ringkasan psikolog.
- **Isi:** nama, spesialisasi, rating, harga, bahasa, CTA detail.
- **Anatomi:** avatar, nama, specialty tags, rating row, price, CTA.
- **State:** default, highlighted, unavailable, loading skeleton.
- **Data yang dipakai:** psychologist_name, specialty_list, rating, price, language_list, availability, match_score.
- **Aturan pakai:** dipakai di hasil matching dan list eksplorasi. Card harus cukup ringkas agar beberapa item bisa tampil sekaligus.

### 7.5 Session Card

- **Fungsi:** menampilkan jadwal sesi mendatang.
- **Isi:** tanggal, jam, status, aksi gabung.
- **Anatomi:** date block, time block, status badge, action button.
- **State:** upcoming, active, completed, canceled, waiting.
- **Data yang dipakai:** session_date, session_time, session_type, status, join_link.
- **Aturan pakai:** dipakai di home dan counseling hub. Prioritaskan keterbacaan waktu dan status.

### 7.6 Primary Button

- **Fungsi:** aksi utama.
- **Anatomi:** label, optional icon, loading spinner.
- **State:** default, pressed, loading, disabled.
- **Data yang dipakai:** label, action_type, loading_state.
- **Aturan pakai:** satu primary action per layar jika memungkinkan. Hindari dua primary button dalam satu area visual.

### 7.7 Secondary Button

- **Fungsi:** aksi alternatif.
- **Anatomi:** outline button, label, optional icon.
- **State:** default, pressed, disabled.
- **Data yang dipakai:** label, action_type.
- **Aturan pakai:** jangan lebih dominan dari primary button. Gunakan untuk aksi pendukung atau pembatalan.

### 7.8 Empty State

- **Fungsi:** menunjukkan kondisi kosong.
- **Isi:** ilustrasi, teks singkat, CTA berikutnya.
- **Anatomi:** illustration, title, supporting copy, CTA.
- **State:** default, no-data, first-time.
- **Data yang dipakai:** empty_title, empty_copy, empty_cta, illustration_key.
- **Aturan pakai:** beri arah aksi, jangan cuma menampilkan pesan kosong.

### 7.9 Loading State

- **Fungsi:** memberi feedback saat data diambil.
- **Isi:** skeleton, shimmer, atau animasi ringan.
- **Anatomi:** placeholder blocks, shimmer line, optional microcopy.
- **State:** initial load, refreshing, background fetch.
- **Data yang dipakai:** loading_context, expected_content_type.
- **Aturan pakai:** gunakan ketika fetch butuh waktu lebih dari sesaat. Jangan menampilkan blank screen.

### 7.10 Supportive Message

- **Fungsi:** memberi rasa aman dan dorongan emosional.
- **Aturan pakai:** singkat, hangat, tidak menggurui.
- **Anatomi:** short copy, optional icon or mascot cue.
- **State:** neutral, encouraging, calming, escalation support.
- **Data yang dipakai:** mood_context, screen_context, tone_variant.
- **Aturan pakai:** singkat, hangat, tidak menggurui. Hindari kalimat panjang atau terlalu generik.

### 7.11 Breathing Module

- **Fungsi:** memandu latihan napas.
- **Isi:** animasi, timer, pattern selector.
- **Anatomi:** breathing visual, pattern selector, duration, start/pause control.
- **State:** idle, active, paused, completed.
- **Data yang dipakai:** breathing_pattern, duration_seconds, progress_percent.
- **Aturan pakai:** interaksi sederhana, minim distraksi. Fokus pada ritme visual dan instruksi singkat.

### 7.12 Journal Prompt Card

- **Fungsi:** memberi prompt awal untuk guided journaling.
- **Isi:** pertanyaan, theme chip, CTA tulis.
- **Anatomi:** prompt text, theme chips, write CTA, optional shuffle action.
- **State:** default, personalized, shuffled.
- **Data yang dipakai:** prompt_text, theme_list, prompt_source.
- **Aturan pakai:** gunakan bahasa yang lembut dan tidak terlalu panjang. Satu prompt harus jelas dan mudah dijawab.

### 7.13 Affirmation Card

- **Fungsi:** menampilkan afirmasi harian.
- **Isi:** teks afirmasi, ikon lembut, opsi favorit.
- **Anatomi:** affirmation text, mascot cue, favorite toggle, refresh action.
- **State:** default, saved, refreshed.
- **Data yang dipakai:** affirmation_text, mood_tag, favorite_status, generated_at.
- **Aturan pakai:** satu pesan utama per layar atau per hari. Hindari terlalu banyak variasi dalam satu tampilan.

### 7.14 Companion Chat Bubble

- **Fungsi:** menampilkan interaksi Citta companion chat.
- **Isi:** bubble chat, quick reply, typing indicator.
- **Anatomi:** user bubble, bot bubble, typing indicator, quick replies, suggestion card.
- **State:** sent, received, typing, escalation_prompt.
- **Data yang dipakai:** sender_role, message_text, timestamp, quick_reply_options.
- **Aturan pakai:** respons harus singkat dan reflektif. Jangan meniru terapi klinis penuh.

### 7.15 Crisis Resource Card

- **Fungsi:** akses bantuan darurat.
- **Isi:** hotline, tombol aksi cepat, resource singkat.
- **Anatomi:** urgency badge, hotline list, quick action button, instruction copy.
- **State:** normal, alert, emergency.
- **Data yang dipakai:** hotline_number, resource_name, urgency_level, recommended_action.
- **Aturan pakai:** tampil jelas, tidak tersembunyi, mudah diakses. Ini harus selalu lebih mudah ditemukan daripada fitur sekunder lain.

## 8. Flow Dictionary

### 8.1 First-Time User Flow

`Onboarding -> Login/Register -> Dashboard -> Mood Check-in`

- User baru masuk lewat onboarding.
- Setelah autentikasi, user diarahkan ke dashboard.
- Mood check-in menjadi aksi pertama yang disorot.

### 8.2 AI Matching Flow

`Dashboard -> AI Matching Input -> Loading -> Hasil Matching -> Detail Psikolog`

- User menulis curhatan singkat.
- Sistem menampilkan hasil matching.
- User membuka detail psikolog untuk keputusan lanjut.

### 8.3 Trial Chat Flow

`Detail Psikolog -> Trial Chat -> Timeout -> Booking Upsell`

- Trial chat dipakai sebagai percobaan awal.
- Saat waktu habis, user diarahkan ke booking flow.

### 8.4 Booking Flow

`Detail Psikolog -> Booking Flow -> Payment/Handoff -> Confirmation`

- Flow harus jelas dari detail sampai konfirmasi.
- Jika payment belum aktif, UI tetap harus menjelaskan langkah berikutnya.

### 8.5 Daily Retention Flow

`Push/Reminder -> Dashboard -> Mood Check-in -> Reflection -> Session/Action`

- Tujuan utama flow ini adalah membuat user kembali setiap hari.

### 8.6 Calm Down Flow

`Dashboard -> Breathing Exercise -> Guided Journaling -> Daily Affirmation`

- Flow ini dipakai saat user sedang cemas, capek, atau butuh reset cepat.

### 8.7 Companion Chat Flow

`Dashboard -> AI Companion Chat -> Suggested Action -> Next Step`

- Citta memberi respons reflektif dan mengarahkan user ke aksi ringan berikutnya.

### 8.8 Crisis Flow

`Detected Distress -> Crisis Resource Center -> Hotline / Psikolog / Emergency Action`

- Flow ini harus pendek dan langsung ke bantuan.

## 9. State Dictionary

### 9.1 Global States

- **Loading:** data masih diambil
- **Empty:** tidak ada data
- **Error:** gagal memuat atau validasi gagal
- **Success:** aksi berhasil
- **Disabled:** aksi tidak tersedia

### 9.2 Screen States

- **Onboarding:** first launch / already seen
- **Dashboard:** no session / has session / has streak
- **Mood Check-in:** not selected / selected / saved
- **Matching Input:** empty / typing / ready to submit
- **Matching Result:** scanning / result loaded / no result
- **Detail Psikolog:** available / full / booked / saved
- **Trial Chat:** active / warning / expired
- **Booking:** pending / success / failed
- **Breathing Exercise:** idle / active / completed
- **Guided Journaling:** empty / typing / saved
- **Daily Affirmation:** default / personalized / saved
- **AI Companion Chat:** idle / typing / response ready / escalation suggestion
- **Crisis Resource Center:** normal / alert / emergency

### 9.3 UI States

- **Selected state:** chip, tab, or card yang dipilih
- **Highlighted state:** item paling relevan
- **Locked state:** fitur belum bisa dipakai
- **Error state:** input invalid atau data gagal load
- **Escalated state:** user diarahkan ke resource bantuan

## 10. Data Mapping

Bagian ini menjembatani prototype dengan struktur data yang nanti dibutuhkan saat implementasi.

| Entity | Field Utama | Dipakai Di |
| --- | --- | --- |
| User | id, name, email, avatar, role | Auth, profil, dashboard |
| Mood Entry | date, mood_level, note | Mood check-in, grafik |
| Psychologist | id, name, specialty, language, rating, price | Matching, list, detail |
| Session | id, date, time, status, type | Home, counseling, booking |
| Chat Trial | id, start_time, end_time, status | Trial chat |
| Booking | id, session_id, payment_status | Booking flow |
| Breathing Session | pattern, duration, completion_status | Breathing Exercise |
| Journal Entry | prompt, content, tags, saved_at | Guided Journaling |
| Affirmation | text, mood_tag, favorite_status | Daily Affirmation |
| Companion Chat | message, quick_reply, escalation_flag | AI Companion Chat |
| Crisis Action | hotline, resource_type, urgency_level | Crisis Resource Center |

### 10.1 Suggested Supabase Tables

Tabel berikut adalah bentuk awal yang paling masuk akal untuk prototype ini.

| Table | Purpose | Key Columns |
| --- | --- | --- |
| `profiles` | Data user utama | `id`, `name`, `avatar_url`, `role`, `created_at` |
| `mood_entries` | Log mood harian | `id`, `user_id`, `mood_level`, `mood_label`, `mood_note`, `created_at` |
| `psychologists` | Data psikolog | `id`, `name`, `bio`, `specialty`, `language`, `rating`, `price`, `availability`, `avatar_url` |
| `sessions` | Jadwal sesi konsultasi | `id`, `user_id`, `psychologist_id`, `session_type`, `session_date`, `session_time`, `status`, `join_link` |
| `trial_chats` | Sesi trial 10 menit | `id`, `session_id`, `started_at`, `ended_at`, `status`, `remaining_seconds` |
| `bookings` | Booking dan status pembayaran | `id`, `session_id`, `payment_method`, `payment_status`, `booking_status`, `amount` |
| `settings` | Preferensi aplikasi user | `id`, `user_id`, `notification_pref`, `privacy_pref`, `language_pref`, `theme_pref`, `updated_at` |
| `journal_entries` | Catatan journaling | `id`, `user_id`, `prompt_text`, `content`, `tags`, `saved_at`, `draft_status` |
| `breathing_sessions` | Riwayat latihan napas | `id`, `user_id`, `pattern`, `duration_seconds`, `completion_status`, `created_at` |
| `affirmations` | Afirmasi harian | `id`, `text`, `mood_tag`, `generated_at`, `is_default` |
| `companion_messages` | Riwayat chat Citta | `id`, `user_id`, `sender_role`, `message_text`, `quick_reply_data`, `escalation_flag`, `created_at` |
| `crisis_resources` | Hotline dan resource darurat | `id`, `resource_name`, `hotline_number`, `resource_type`, `urgency_level`, `is_active` |

### 10.2 Relasi Utama

- `profiles.id` → relasi ke semua data user.
- `mood_entries.user_id` → satu user punya banyak mood entry.
- `sessions.user_id` dan `sessions.psychologist_id` → satu sesi mengikat user dan psikolog.
- `trial_chats.session_id` → trial chat menempel ke sesi atau psikolog tertentu.
- `bookings.session_id` → booking mengacu ke sesi yang sama.
- `journal_entries.user_id`, `breathing_sessions.user_id`, `companion_messages.user_id` → semua fitur self-help menempel ke user yang sama.

### 10.3 Field to Screen Mapping

| Screen | Data Utama |
| --- | --- |
| Onboarding | `seen_onboarding`, `locale` |
| Login/Register | `email`, `password`, `auth_provider` |
| Dashboard | `name`, `avatar_url`, `today_mood`, `streak_count`, `next_session` |
| Mood Check-in | `mood_level`, `mood_label`, `mood_note` |
| AI Matching Input | `curhatan_text`, `issue_tags`, `language_pref`, `location_pref` |
| Hasil Matching | `recommended_psychologists`, `match_reason`, `confidence_level` |
| Detail Psikolog | `name`, `specialty`, `language`, `price`, `rating`, `availability` |
| Trial Chat | `message_list`, `timer_remaining`, `session_status` |
| Booking Flow | `session_type`, `slot_time`, `payment_method`, `payment_status` |
| Profil | `name`, `email`, `history_links` |
| Settings | `notification_pref`, `privacy_pref`, `language_pref`, `theme_pref` |
| Breathing Exercise | `breathing_pattern`, `duration_seconds`, `completion_status` |
| Guided Journaling | `prompt_text`, `journal_content`, `tags`, `draft_status` |
| Daily Affirmation | `affirmation_text`, `mood_tag`, `favorite_status` |
| AI Companion Chat | `user_message`, `bot_reply`, `quick_replies`, `escalation_flag` |
| Crisis Resource Center | `hotline_list`, `resource_links`, `urgency_level` |

### 10.4 Data Scope Notes

- Data self-help seperti journaling, breathing, affirmation, dan companion chat harus disimpan per user.
- Data booking dan sesi harus punya `status` yang eksplisit supaya flow revenue dan trial-to-paid bisa dilacak.
- Data crisis resource sebaiknya disimpan sebagai reference table, bukan hardcoded di UI.

## 11. Behavior Rules

Bagian ini menjelaskan bagaimana layar dan komponen harus berperilaku agar implementasi konsisten.

### 11.1 Global Behavior Rules

- Gunakan satu primary action yang paling menonjol di tiap layar.
- Jika data belum tersedia, tampilkan loading state atau empty state, jangan layar kosong.
- Semua copy harus memakai tone hangat dan suportif.
- Transisi antar state harus halus dan konsisten, bukan mendadak.
- Fitur self-help harus bisa diakses tanpa membuat user merasa sedang diuji.

### 11.2 Dashboard Behavior

- Dashboard harus menampilkan kondisi user hari ini dengan jelas dalam 3 detik pertama.
- Mood check-in harus menjadi aksi teratas untuk user yang belum check-in hari ini.
- Jika ada session mendatang, session card harus mengalahkan kartu sekunder lain.
- Jika tidak ada session, tampilkan empty state dengan CTA ke AI matching.

### 11.3 Mood Check-in Behavior

- Hanya satu mood yang boleh aktif pada satu waktu.
- Saat mood dipilih, chip lain tetap visible namun tidak aktif.
- Setelah mood disimpan, user kembali ke dashboard dengan state terbaru.
- Jika user belum menambah catatan, mood tetap bisa disimpan.

### 11.4 AI Matching Behavior

- Input curhatan boleh singkat; jangan memaksa user menulis panjang.
- Jumlah kategori masalah dibatasi agar hasil matching tetap fokus.
- Loading analisis harus memberi kesan sedang memproses, bukan error.
- Jika hasil kosong, berikan retry action dan saran input yang lebih spesifik.

### 11.5 Detail Psikolog Behavior

- CTA utama berubah sesuai ketersediaan: trial chat jika tersedia, booking jika slot trial tidak tersedia.
- Harga, rating, dan bahasa harus selalu terlihat sebelum CTA.
- Jika slot penuh, tampilkan penjelasan singkat dan alternatif waktu.

### 11.6 Trial Chat Behavior

- Timer harus selalu terlihat selama sesi aktif.
- Saat waktu hampir habis, tampilkan peringatan ringan tanpa panik.
- Ketika sesi habis, dialog upsell harus jelas dan langsung ke langkah berikutnya.
- Jika koneksi gagal, simpan status sesi dan tampilkan retry.

### 11.7 Booking Behavior

- Booking flow harus menampilkan ringkasan sesi sebelum pembayaran atau handoff.
- Payment pending, success, dan failed harus masing-masing punya state yang jelas.
- Jika payment belum tersedia, UI harus menjelaskan langkah lanjutan secara transparan.

### 11.8 Breathing Exercise Behavior

- Animasi napas harus menjadi pusat perhatian layar.
- Pattern selector tidak boleh terlalu banyak dalam satu layar awal.
- Jika user pause, visual harus tetap stabil dan tidak reset otomatis.
- Setelah selesai, berikan CTA ke jurnal atau affirmation sebagai next step lembut.

### 11.9 Guided Journaling Behavior

- Prompt harus membantu user mulai menulis, bukan mengarahkan terlalu keras.
- Draft autosave lebih baik daripada mengandalkan submit manual saja.
- Jika user keluar sebelum menyimpan, tampilkan reminder kecil.

### 11.10 Daily Affirmation Behavior

- Afirmasi harian boleh berubah sesuai mood context.
- Satu kartu hanya memuat satu pesan utama.
- Favorit harus bisa disimpan tanpa memaksa navigasi tambahan.

### 11.11 AI Companion Chat Behavior

- Respon Citta harus singkat, reflektif, dan aman.
- Jika mendeteksi distress berat, companion chat harus menawarkan crisis resource.
- Quick reply hanya dipakai untuk membantu user memulai, bukan menggantikan jawaban panjang.

### 11.12 Crisis Resource Behavior

- Crisis Resource Center harus selalu mudah dijangkau dari companion chat dan manual access.
- Informasi hotline harus tampil langsung tanpa langkah tambahan.
- Jika user memilih kontak bantuan, tindakan harus secepat mungkin.

## 12. Copy and Microcopy

### 12.1 Tone Rules

- Hangat
- Ringkas
- Tidak menghakimi
- Tidak terlalu medis

### 12.2 Default Copy Examples

- Empty mood: `Belum ada cerita hari ini. Mulai dari yang paling ringan.`
- Loading match: `Kami lagi nyari yang paling cocok buat kamu.`
- Trial ended: `Waktu coba chat sudah habis. Kalau nyaman, lanjutkan ke sesi penuh.`
- Error umum: `Ada kendala, coba lagi sebentar ya.`

## 12. Acceptance Criteria

Prototype dianggap cukup lengkap untuk development jika:

- Semua layar inti sudah punya tujuan, isi, dan CTA
- Semua komponen reusable sudah dideskripsikan
- Semua flow utama sudah berurutan
- State loading, empty, error, dan success sudah ditentukan
- Data field utama sudah dipetakan
- Terminologi sudah konsisten

## 13. Glossary

| Istilah | Arti yang Dipakai |
| --- | --- |
| User | Pengguna aplikasi mobile |
| Psychologist / Psikolog | Mitra ahli yang memberi sesi |
| Trial Chat | Chat percobaan gratis 10 menit |
| Booking | Pemesanan sesi penuh |
| Mood Check-in | Input kondisi emosi harian |
| Home Visit | Sesi offline di lokasi user |
| AI Matching | Rekomendasi psikolog berbasis input user |
| Breathing Exercise | Latihan napas terpandu untuk menenangkan diri |
| Guided Journaling | Menulis jurnal dengan prompt terarah |
| Daily Affirmation | Pesan singkat untuk dukungan emosional harian |
| AI Companion Chat | Chat reflektif ringan bersama Citta |
| Crisis Resource Center | Pusat akses bantuan darurat dan hotline |

## 14. Priority

- **MVP:** onboarding, login, dashboard, mood check-in, matching, detail psikolog, trial chat, booking
- **Should have:** profil, settings, state lengkap, microcopy final, breathing exercise, guided journaling, daily affirmation
- **Nice to have:** AI companion chat, crisis resource center
- **Later:** dark mode, custom animations, extra illustrations

## 15. Implementation Notes

### 15.1 Framework

- Flutter dengan Riverpod
- GoRouter untuk navigasi
- Supabase untuk auth dan database
- MingCute / Iconsax untuk ikon

### 15.2 Color System

Semua warna harus diambil dari `lib/core/theme/app_colors.dart`.

- Dilarang hardcoded `Color(0xFF...)` langsung di widget
- Pengecualian hanya untuk `Colors.white`

### 15.3 Font Loading

- Plus Jakarta Sans via `GoogleFonts.plusJakartaSans()`
- Semua helper method non-const, jadi jangan dipakai di konteks widget `const`

## 16. Open Questions / Future

- Dark mode implementation
- Citta maskot asset creation
- Animasi transisi antar screen
- Ilustrasi custom untuk empty states
