# TemanCrita — Business System Map

## Posisi Sistem dalam Bisnis

```
┌─────────────────────────────────────────────────────────────┐
│                     BUSINESS LAYER                          │
│  Revenue, Pricing, Marketing, B2B, CSR                     │
├─────────────────────────────────────────────────────────────┤
│                     PRODUCT LAYER                           │
│  Flutter App  ←→  Admin Dashboard  ←→  Supabase + Gemini   │
├─────────────────────────────────────────────────────────────┤
│                     TECHNICAL LAYER                         │
│  Dart / Flutter  |  React / Vite  |  PostgreSQL  |  AI     │
└─────────────────────────────────────────────────────────────┘
```

**Flutter App** = satu-satunya komponen yang langsung bersentuhan dengan *customer*.

---

## 1. Revenue Streams

### 1.1 Komisi Konsultasi (Core Revenue)
**Model:** Marketplace — mempertemukan user dengan psikolog, ambil komisi.

| Komponen | Detail |
|----------|--------|
| Mekanisme | User booking sesi → bayar via platform → psikolog terima setelah dipotong komisi |
| Komisi | 10-20% per sesi (dari business plan) |
| Harga | Rp 100K – 200K/sesi (lihat `PsikologDetailScreen`) |
| Status Teknis | UI selesai (listing, detail, chat trial), **payment gateway belum connect** |
| Target Market | Primary: usia 18-35, mahasiswa & pekerja muda |

**Technical touchpoints:**
- `ExplorePsikologScreen` — Discovery + filter psikolog
- `PsikologDetailScreen` — Profil lengkap + CTA booking
- `ChatRoomScreen` — Trial 10 menit (upsell mechanism)
- Tabel `consultations` di Supabase — Tracking booking & status

### 1.2 Trial-to-Paid Upsell
**Model:** Gratis 10 menit → konversi ke sesi penuh berbayar.

```
User masuk ChatRoomScreen
  → Timer 10:00 mulai countdown
  → Bot dengan hardcoded keyword responses
  → Waktu habis → dialog muncul:
       "Sesi trial 10 menitmu telah berakhir."
       [Nanti Saja] [Booking Sekarang]
```

**Status:** Flow lengkap (`ChatRoomScreen.dart:39-56`), tapi button "Booking Sekarang" masih pop ke halaman sebelumnya (belum ke payment).

### 1.3 Bundle Sesi (Volume Discount)
**Model:** Commit di muka dengan diskon — naikkan average order value.

| Komponen | Detail |
|----------|--------|
| Mekanisme | "Beli 3 sesi, hemat 20%" — bayar di muka, pakai kapan saja |
| Contoh Harga | 1 sesi Rp150K, 3 sesi Rp360K (hemat Rp90K) |
| Psikologi | **Endowment Effect** — setelah punya 3 sesi, user merasa rugi kalau tidak dipakai |
| Status Teknis | Tinggal modify `PsikologDetailScreen` + backend track sisa sesi |

### 1.4 Kampus Partnership (Traction-First Revenue)
**Model:** Jual paket akses ke universitas — target primary persona (18-24th).

| Komponen | Detail |
|----------|--------|
| Target | BEM/UKM, fakultas, kemahasiswaan |
| Paket | X akses untuk Y mahasiswa, termasuk workshop/webinar |
| Harga | Rp 5-10 Juta/semester untuk 500 mahasiswa |
| Status Teknis | **Tidak perlu coding** — pakai prototype yang sudah ada buat demo |
| Sales | Tim turun langsung ke kampus, demo app, closing deal |
| Keuntungan | Validasi pasar + revenue awal + brand awareness + user base |

### 1.5 Corporate B2B & Subscription Premium (Future)
**Model:** Untuk Tahun 2+ — dilewati dulu di fase pre-launch.

| Item | Alasan Skip |
|------|-------------|
| **B2B Corporate** | Butuh sales team, case study, legal contract — terlalu berat untuk 3 orang pre-launch |
| **Subscription Premium** | Butuh fitur eksklusif signifikan (meditasi, konten) yg belum ada |
| **Paid Group Sessions** | Butuh psikolog mitra + jadwal tetap + user base |
| **Family Plan** | Butuh sistem akun keluarga — coding berat |

---

## 2. Metrik & KPI

| Metrik | Definisi | Touchpoint Teknis |
|--------|----------|-------------------|
| **DAU/MAU** | Daily/Monthly Active Users | Auth session + tab switches |
| **Mood Check-in Rate** | % user yg check-in mood tiap hari | `MainDashboard._moodCheckin()` |
| **AI Matching Conversion** | % user yg selesai curhat → lihat hasil | `CurhatanAwalScreen` → `MatchingResultScreen` |
| **Trial-to-Booking Rate** | % user trial 10 menit → booking penuh | `ChatRoomScreen` timer → expired dialog |
| **Psikolog Discovery Rate** | % user yg tap detail setelah lihat card | `ExplorePsikologScreen` → `PsikologDetailScreen` |
| **Retention D7/D30** | User kembali hari 7 / hari 30 | Auth session history |

---

## 3. Cost Structure

| Item | Estimasi (dari business plan) | Komponen Teknis |
|------|-------------------------------|-----------------|
| CAPEX Awal | Rp 1-1,2 Miliar | Development, design, legal |
| Server & Cloud | Monthly | Supabase (Auth + DB + Storage), Gemini API |
| Gemini API | Per request | `gemini-1.5-flash` — biaya per 1K karakter |
| Google Sign-In | Gratis | OAuth 2.0 |
| App Distribution | Rp 200-500K/thn | Google Play Developer |
| Apple Developer | $99/thn | App Store distribution |
| Ops Tim | Gaji | CEO, CTO, CMO, COO, CFO, HRD |

### Gemini API Cost Projection
```
Prompt rata-rata: ~500 token input + ~200 token output
Biaya gemini-1.5-flash: $0.075/1M input, $0.30/1M output
Per matching: ~$0.0001 (sangat murah)
10.000 matching/bulan: ~$1
```

---

## 4. User Journey → Revenue Mapping

```
Akuisisi ──► Aktivasi ──► Engagement ──► Revenue ──► Retention
  │            │              │              │            │
  ▼            ▼              ▼              ▼            ▼
Social    Register     Mood check-in    Booking      Follow-up
Ads /     (Email /     setiap hari      sesi         otomatis
Kampus    Google)      + AI Matching    berbayar     + notif
                       + Chat trial
```

### Funnel

| Tahap | Aksi User | Revenue Event | Screen |
|-------|-----------|---------------|--------|
| **Awareness** | Webinar kampus / sosial media | — | — |
| **Acquisition** | Link kampus / download app | — | — |
| **Activation** | Register (email/ Google) | — | `LoginScreen` / `RegisterScreen` |
| **Engagement** | Check-in mood | — | `MainDashboard` |
| **Engagement** | Curhat ke AI | — | `CurhatanAwalScreen` |
| **Discovery** | Explore psikolog | — | `ExplorePsikologScreen` |
| **Trial** | Chat 10 menit gratis | — | `ChatRoomScreen` |
| **Revenue Event** | Booking sesi penuh | **💰 Komisi** | `PsikologDetailScreen` → (future: payment) |
| **Revenue Event** | Bundle 3 sesi | **💰 Bundle** | `PsikologDetailScreen` |
| **Revenue Event** | Deal kampus closing | **💰 Kampus** | Offline sales |
| **Retention** | Check-in mood + streak | — | `MainDashboard._StreakCard` |
| **Retention** | Follow-up notif | — | (future: push notif) |

---

## 5. Kompetitor & Diferensiasi

| Kompetitor | Model Revenue | Keunggulan TemanCrita |
|------------|--------------|----------------------|
| **Riliv** | Komisi sesi + subscription | AI Matching + Hybrid (online/offline) |
| **Halodoc** | Ekosistem medis umum | Fokus khusus mental health |
| **Bicarakan.id** | Per sesi | Trial chat 10 menit tanpa daftar kartu |
| **Psikologimu** | Per sesi | AI-powered recommendation |

---

## 6. Roadmap Revenue (Disesuaikan — Tim 3 Orang, Pre-Launch)

### Fase 1 — Launch (Bulan ini)
| Action | Prioritas | Timeline |
|--------|-----------|----------|
| ✅ Core app sudah jadi | — | — |
| 🟡 Connect payment gateway (Midtrans/Xendit) | **P1** | 1 minggu |
| 🟡 Fix "Booking Sekarang" button di expired dialog → payment | **P1** | 1 hari |
| 🟡 Bundle sesi — "Beli 3 hemat 20%" di detail psikolog | **P1** | 2-3 hari |

**Target:** Bisa terima revenue minggu depan.

### Fase 2 — Traction (1-2 Bulan Pertama)
| Action | Prioritas | Detail |
|--------|-----------|--------|
| 🟢 Demo ke kampus (BEM, fakultas, kemahasiswaan) | **P1** | Tim turun langsung, pakai prototype yang sudah ada |
| 🟢 Webinar kesehatan mental gratis di 3-5 kampus | **P1** | Building trust + lead generation |
| 🟢 Partnership deal: Rp 5-10jt/semester | **P1** | Bayar di muka, akses untuk X mahasiswa |
| 🟡 Push notification (FCM) buat retention | **P2** | Biar user balik check-in mood + streak |

**Target:** 3 partnership kampus ~ Rp 15-30jt revenue.

### Fase 3 — Scale (Bulan 3-6)
- Evaluate traction: berapa user, berapa booking, berapa churn
- Kalau valid: hire 1-2 orang (bisa part-time)
- Review: apakah perlu B2B, subscription, atau fitur baru
- Kalau tidak valid: pivot berdasarkan data

### Fase 4 — Ekspansi (Tahun 2)
- B2B Corporate (kalau sudah ada case study dari kampus)
- Home visit layanan offline
- AI predictive analytics

---

## 7. Status Implementasi vs Rencana Bisnis

| Item | Prioritas | Status Teknis | Target Selesai |
|------|-----------|--------------|----------------|
| AI Matching | P1 | ✅ `GeminiRepository` siap, screen masih mock | — |
| Mood Tracking | P1 | ✅ Fitur check-in + bar chart | — |
| Trial Chat | P1 | ✅ Timer 10 menit + expired dialog | — |
| Payment Gateway | **P1** | ❌ Belum connect | **Minggu ini** |
| Booking → Payment | **P1** | 🟡 Button masih `context.pop()` | **1 hari** |
| Bundle Sesi | **P1** | ❌ Belum ada UI tier pricing | **2-3 hari** |
| Kampus Partnership | P1 | ❌ Sales offline (tidak perlu coding) | **1-2 bulan** |
| Push Notification (FCM) | P2 | ❌ Belum | Setelah payment live |
| Admin Dashboard | P2 | 🟡 Init React + Supabase | Setelah payment live |
| Follow-up Otomatis | P3 | ❌ Belum | Scale phase |
| B2B Corporate | Skip | ❌ Terlalu berat untuk 3 org pre-launch | Tahun 2 |
| Subscription Premium | Skip | ❌ Butuh konten eksklusif | Tahun 2 |
| Komunitas / Forum | Skip | ❌ Butuh user base | Tahun 2+ |
