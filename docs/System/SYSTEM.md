# TemanCrita — System Architecture

## Overview

TemanCrita adalah platform kesehatan mental dengan 5 komponen utama:

```
┌──────────────────────────────────┐
│ ┌──────────────────────────────┐ │
│ │      Landing Page            │ │  ← NEW — untuk SEO, partnership,
│ │   (Next.js / Static Site)    │ │     pre-launch funnel, download link
│ │   SEO, Waitlist, Blog,       │ │
│ │   Pricing, About             │ │
│ └──────────────┬───────────────┘ │
│                │                 │
│ ┌──────────────▼───────────────┐ │
│ │        Flutter App            │ │
│ │     (User-facing — Mobile)    │ │
│ │     iOS & Android             │ │
│ └──────────────┬───────────────┘ │
│                │                 │
│ ┌──────────────▼───────────────┐ │
│ │     Admin Dashboard          │ │
│ │   (Web / React + Tailwind)   │ │
│ │   Manajemen Psikolog,        │ │
│ │   Booking, Revenue           │ │
│ └──────────────┬───────────────┘ │
│                │                 │
│ ┌──────────────▼───────────────┐ │
│ │         Supabase              │ │
│ │  ┌────────┐ ┌────────┐      │ │
│ │  │ Auth   │ │  DB    │      │ │
│ │  │(Google,│ │Postgres│      │ │
│ │  │ Email) │ │       │      │ │
│ │  └────────┘ └────────┘      │ │
│ └──────────────┬───────────────┘ │
│                │                 │
│ ┌──────────────┴───────────────┐ │
│ │  Payment    │  Google Gemini │ │
│ │  Gateway    │  AI Matching   │ │
│ │  Midtrans   │  1.5 Flash     │ │
│ └─────────────┴────────────────┘ │
│                                  │
│       SEMUA DI-HOSTING           │
│       DI Vercel / Supabase       │
└──────────────────────────────────┘
```

---

## 1. Flutter App (User-Facing)

**Posisi:** Frontend mobile — satu-satunya titik kontak langsung dengan pengguna.

**Stack:**
| Layer | Teknologi |
|-------|-----------|
| Language | Dart 3.4+ |
| Framework | Flutter (Material 3) |
| State Management | Riverpod (`flutter_riverpod`) |
| Routing | GoRouter (`go_router`) |
| Auth | Supabase Auth + Google Sign-In |
| AI | Google Gemini 1.5 Flash (`google_generative_ai`) |
| Icons | MingCute / Iconsax (`icons_plus`) |
| Font | Plus Jakarta Sans (`google_fonts`) |
| Local Storage | Isar (declared, belum digunakan) |
| HTTP | Dio (untuk future API calls) |
| Environment | `flutter_dotenv` (`.env`) |

### Struktur Folder (`lib/`)

```
lib/
├── main.dart                           # Entry point + AppShell (bottom nav)
├── core/
│   ├── theme/
│   │   ├── app_colors.dart             # Warna, typography helpers, cardDeco
│   │   └── app_theme.dart              # ThemeData Material 3
│   └── router/
│       └── app_router.dart             # GoRouter config + auth redirect guard
├── features/
│   ├── splash/
│   │   └── presentation/pages/splash_screen.dart
│   ├── auth/
│   │   ├── data/auth_repository.dart   # Supabase Auth calls
│   │   └── presentation/
│   │       ├── pages/login_screen.dart
│   │       ├── pages/register_screen.dart
│   │       └── providers/auth_provider.dart  # Riverpod state
│   ├── dashboard/
│   │   ├── widgets/main_dashboard.dart  # Home page (mood, cards, graph)
│   │   ├── ui_lab_screen.dart          # UI Lab selector
│   │   └── wello_ui_lab.dart           # Design reference (1130 lines)
│   ├── ai_matching/
│   │   ├── data/gemini_repository.dart  # Gemini API calls
│   │   └── presentation/pages/
│   │       ├── curhatan_awal_screen.dart  # Input curhatan
│   │       └── matching_result_screen.dart # Hasil AI matching
│   └── marketplace/
│       └── presentation/pages/
│           ├── explore_psikolog_screen.dart  # List + filter psikolog
│           ├── psikolog_detail_screen.dart    # Detail profil
│           └── chat_room_screen.dart          # Chat trial 10 menit
```

### Routing & Auth Flow

```
/splash  ──►  (auto detect session)
                ├── tidak login  ──►  /login  ──►  /register
                └── sudah login  ──►  /home (AppShell)
                                         ├── Tab 0: MainDashboard (Home)
                                         ├── Tab 1: ExplorePsikologScreen
                                         ├── Tab 2: CurhatanAwalScreen
                                         ├── Tab 3: Mood Tracker (placeholder)
                                         └── Tab 4: Profil Saya (placeholder)
```

Auth guard di `app_router.dart`: redirect otomatis ke `/login` jika session null, dan ke `/home` jika sudah login tapi mencoba akses halaman auth.

### AppShell (Bottom Navigation)

5 tab dengan IndexedStack:
- **Home** — Dashboard utama (mood check-in, refleksi, sesi, grafik mood, quick actions, streak)
- **Eksplor** — Cari psikolog (search + filter kategori)
- **Curhat AI** — Tombol center (lingkaran) untuk input curhatan
- **Mood** — Placeholder
- **Profil** — Placeholder

### Home Dashboard (`main_dashboard.dart`)

Komponen berurutan (vertikal scroll):
1. **Header** — Avatar (Google photo / initials fallback) + greeting + notifikasi
2. **Mood Check-in** — 5 emoji (Buruk → Hebat), animated container
3. **Bento Row** — `LayoutBuilder`: side-by-side (≥340dp) atau stacked
   - TodayReflectionCard — Kutipan AI temanCrita
   - UpcomingSessionCard — 4 hari (highlight active day)
4. **MoodGraphCard** — Bar chart 7 hari (Minggu ini)
5. **Quick Actions** — Horizontal scroll (Napas Dalam, Jurnal, Cerita ke AI, Tidur)
6. **StreakCard** — Primary teal background, 7 hari streak

### AI Matching Flow

```
CurhatanAwalScreen
  │  Pilih kategori (max 3) + tulis cerita
  │  Tekan "Temukan Psikolog Untukku"
  ▼
MatchingResultScreen
  │  1. Scanning animation (3 detik)
  │  2. Tampilkan 3 rekomendasi psikolog
  │     └─ Tiap card → tap → PsikologDetailScreen
  ▼
PsikologDetailScreen
  │  Lihat profil, stat, spesialisasi
  │  └─ "Coba Chat 10 Menit" → ChatRoomScreen
  │  └─ "Booking Sesi Penuh" → (belum diimplementasi)
  ▼
ChatRoomScreen
  ├── Timer countdown 10 menit
  ├── Hardcoded keyword responses
  └── Expired dialog → booking upsell
```

Catatan: `GeminiRepository` sudah ada tetapi `_startAnalysis()` di `MatchingResultScreen` masih menggunakan delay simulasi (3 detik), belum memanggil Gemini.

---

## 2. Landing Page (Single Page)

**Posisi:** Web presence minimal — bukan buat jual sesi (transaksi di apps), tapi buat SEO + kredibilitas + funnel download.

Saat ini: **belum ada.**

**Prinsip:** Karena produknya mobile app, landing page cukup **1 halaman** — gak perlu blog, pricing page, atau halaman terpisah.

### Fungsi Landing Page

| Untuk Siapa | Fungsinya |
|-------------|-----------|
| **User potensial** | Google "aplikasi curhat online" → nemu landing page → download app |
| **Kampus partnership** | Waktu pitch, mereka googling "TemanCrita" → ada website profesional |
| **Pre-launch** | Kumpulin email via waitlist form sebelum app launch |
| **Investor/pihak ketiga** | Cek kredibilitas — startup tanpa website = red flag |

### Stack

| Layer | Pilihan | Alasan |
|-------|---------|--------|
| Framework | **Static HTML/CSS** atau Next.js | Static lebih cepat & gratis |
| Hosting | Vercel / GitHub Pages | Gratis, deploy dari push |
| Domain | temancrita.com atau temancrita.id | — |

### Konten 1 Halaman

```
┌──────────────────────────────────┐
│  Hero: "Karena Kamu Gak         │
│  Sendirian" + CTA Download      │
├──────────────────────────────────┤
│  Cara Kerja (3 langkah):        │
│  Curhat → AI Match → Konseling  │
├──────────────────────────────────┤
│  Fitur Utama (3 card):           │
│  AI Matching / Trial Chat /     │
│  Mood Tracker                    │
├──────────────────────────────────┤
│  Testimoni / Social Proof        │
├──────────────────────────────────┤
│  Waitlist Form (email)           │
├──────────────────────────────────┤
│  Footer: "For Campus" link +    │
│  Social media                    │
└──────────────────────────────────┘
```

**CTA utama:** "Download App" (nanti link ke Play Store).
**CTA sekunder:** "Gabung Waitlist" (simpan email ke Supabase).

---

## 3. Payment Gateway

**Posisi:** Menangani pembayaran booking sesi dan bundle. Saat ini: **belum ada.**

| Komponen | Pilihan | Alasan |
|----------|---------|--------|
| Provider | **Midtrans** (Snap API) | Paling populer di Indonesia, support semua metode (QRIS, VA, Gopay, Kartu) |
| Integrasi | Server-side (via Supabase Edge Functions) | Biar API key tidak bocor ke client |
| Webhook | Midtrans → Supabase update `consultations.status` | Otomatis update booking status |

**Flow Pembayaran:**
```
User pilih "Booking Sesi" / "Beli Bundle"
    → Masukkan jumlah sesi
    → Pilih metode bayar (QRIS/Gopay/VA)
    → Midtrans Snap API → generate payment link
    → User bayar
    → Midtrans webhook → Supabase update status
    → User dapat notifikasi "Sesi kamu aktif!"
    → Psikolog terima notifikasi booking baru
```

---

## 4. Admin Dashboard (Web)

**Posisi:** Internal admin — mengelola data psikolog, konsultasi, user.

**Stack:**
| Layer | Teknologi |
|-------|-----------|
| Language | TypeScript |
| Framework | React 18 + Vite |
| Styling | Tailwind CSS 3 + lucide-react |
| Backend | Supabase JS Client |

**Status:** Masih tahap awal — hanya inisialisasi project + config Supabase. Belum ada komponen atau halaman.

```
admin_dashboard/
├── package.json
├── tailwind.config.js
├── src/
│   ├── lib/
│   │   └── supabase.ts          # Supabase client init
│   └── components/              # (kosong)
```

---

## 5. Supabase (Backend)

**Posisi:** Backend-as-a-Service — auth, database, storage.

### Database Tables

```sql
-- Users (auto-managed by Supabase Auth)
auth.users

-- Profiles (auto-sync dari auth)
profiles (id, display_name, email, avatar_url, updated_at)

-- Psychologists (master data via admin)
psychologists (id, name, specialization[], bio, price_per_session,
               rating, languages[], image_url, is_available, created_at)

-- Mood logs (dari user daily check-in)
mood_logs (id, user_id, mood_score[1-5], notes, category, created_at)

-- Consultations (booking + meeting links)
consultations (id, user_id, psychologist_id, scheduled_at,
               status[pending/confirmed/completed], meeting_link, created_at)
```

### Auth Providers
- Email + Password
- Google OAuth (via `google_sign_in` + Supabase `signInWithIdToken`)

---

## 6. Google Gemini AI

**Posisi:** Third-party AI — analisis curhatan → matching psikolog.

**Model:** `gemini-1.5-flash`

**Prompt:** Asisten klinis empatik → output JSON:
- `Specialty` — Spesialisasi psikologi
- `DoctorName` — Nama psikolog fiktif
- `Reasoning` — Alasan personal (2 kalimat, merujuk detail curhatan)
- `Tone` — Kata sifat kondisi emosi
- `Suggestion` — Saran praktis hari ini

---

## 7. Data Flow
```
[Flutter] ──signInWithGoogle()──► [Google OAuth]
     │                                    │
     │◄───────── idToken ─────────────────┘
     │
     └──signInWithIdToken()──► [Supabase Auth]
                                    │
                              Create session
                                    │
                              Update profiles table
```

### AI Matching Flow
```
[Flutter: CurhatanAwalScreen]
     │
     ├── Pilih kategori + tulis teks
     │
     └── context.push('/matching-result', extra: text)
              │
              ▼
     [MatchingResultScreen]
              │
              ├── (saat ini) delay 3 detik → tampilkan 3 mock psikolog
              └── (future) panggil GeminiRepository.analyzeAndMatch()
                           │
                           ▼
                    [Gemini 1.5 Flash]
                           │
                    Return JSON (specialty, name, reasoning, etc.)
```

### Psikolog Marketplace Flow
```
[ExplorePsikologScreen] ──tap──► [PsikologDetailScreen]
       │                                  │
  Search + filter                    Lihat detail + booking
       │                                  │
  Mock data (4 psikolog)             ┌────┴────┐
                                     ▼         ▼
                              ChatRoom     Booking
                              (10 menit)   (belum ada)
```

---

## 8. Environment Variables (`.env`)

```
# Supabase
SUPABASE_URL=https://orgxbmvhdzgwwvzyghmy.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Google
GEMINI_API_KEY=AIzaSyA...
GOOGLE_WEB_CLIENT_ID=145016600699-...apps.googleusercontent.com

# Midtrans (belum ada — perlu didaftarkan)
MIDTRANS_SERVER_KEY=
MIDTRANS_CLIENT_KEY=
```

---

## 9. Dependencies Key (pubspec.yaml)

| Package | Kegunaan |
|---------|----------|
| `flutter_riverpod` | State management |
| `supabase_flutter` | Backend auth + database |
| `go_router` | Routing + auth guard |
| `google_sign_in` | Google OAuth |
| `google_generative_ai` | Gemini AI matching |
| `google_fonts` | Plus Jakarta Sans + Inter |
| `icons_plus` | MingCute / Iconsax icons |
| `flutter_svg` | SVG assets (logo) |
| `icons_plus` | MingCute / Iconsax icons |
| `dio` | HTTP client (future) |
| `isar` | Local database (future) |
| `lottie` | Animations (future) |
| `intl` | Date formatting |
| `url_launcher` | External links |
| `flutter_dotenv` | .env loading |
| `firebase_messaging` | Push notification (FCM) — belum ada |
| `firebase_core` | Firebase init — belum ada |

---

## 10. Business-Technology Gap Analysis

Berikut gap antara kondisi teknis saat ini dengan kebutuhan bisnis (dari BUSINESS-SYSTEM.md):

| Kebutuhan Bisnis | Status Teknis | Dampak ke Bisnis | Prioritas |
|-----------------|---------------|------------------|-----------|
| **Landing Page** (1 halaman) — SEO, kredibilitas, waitlist | ❌ Belum ada | Kampus partnership gak bisa demo website. User cari TemanCrita di Google gak nemu. | **P1** |
| **Payment Gateway** — komisi sesi, bundle | ❌ Belum ada | **Revenue = 0.** Tidak bisa booking berbayar. | **P1** |
| **Kampus Partnership Dashboard** — portal khusus untuk mitra | ❌ Belum ada | Sales ke kampus manual tanpa sistem | **P1** (non-tech) |
| **Admin Dashboard** — manage psikolog, booking, revenue | 🟡 Init React, belum ada UI | Tidak bisa kelola data psikolog & lihat transaksi | P2 |
| **Push Notification (FCM)** — reminder check-in mood, follow-up | ❌ Belum ada | Retention rendah, streak gak efektif | P2 |
| **Gemini AI Connect** — AI matching real dari curhatan | 🟡 Repository siap, screen masih mock | AI Matching cuma animasi, belum fungsi | P2 |
| **AI Chat** — chat psikolog pake AI (bukan hardcoded) | ❌ Responses hardcoded | Chat trial terbatas, gak scalable | P3 |
| **Data Real** — psikolog, konsultasi dari Supabase DB | ❌ Masih mock data | Aplikasi cuma prototype, tidak production-ready | P3 |
| **Isar Local DB** — offline cache mood, session | ❌ Belum dipakai | Belum dibutuhkan di tahap ini | Skip |

### Prioritas Upgrade (Business-Driven)

```
Minggu ini:
  └─ Payment Gateway (Midtrans) — buka revenue stream

1-2 Minggu:
  └─ Landing Page (1 halaman, static) — SEO + kredibilitas kampus
  └─ Waitlist form + Supabase table (email capture)

1-2 Bulan:
  └─ Push Notification (FCM)
  └─ Admin Dashboard dasar (manage psikolog, lihat booking)
  └─ Gemini connect ke MatchingResultScreen

Scale (setelah validated):
  └─ AI Chat
  └─ Real data from Supabase
  └─ Isar offline cache
```
