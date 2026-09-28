# MMC PONSEL — Setup Produksi

## 1. Supabase
Buat project di Supabase. Jalankan seluruh isi `supabase_schema.sql` di SQL Editor.
Kemudian ambil Project URL dan Publishable/anon key dari Project Settings > API.
Isi `www/supabase-config.js`.

Supabase Auth mendukung email/password serta Google dan Facebook OAuth. Untuk Google/Facebook, provider harus diaktifkan dan kredensial OAuth serta redirect URL dikonfigurasi di dashboard provider/Supabase.

## 2. OAuth
Google:
- Buat OAuth client di Google Cloud/Google Auth Platform.
- Tambahkan redirect URL yang diberikan Supabase.
- Aktifkan provider Google di Supabase Auth.

Facebook:
- Buat Facebook App.
- Aktifkan Facebook Login.
- Masukkan App ID/Secret ke Supabase Auth dan konfigurasi redirect URI.

## 3. Data & foto
Produk, order, dan profil disimpan di PostgreSQL.
Foto produk masuk ke bucket `product-images`.
RLS membatasi penulisan produk/order ke pengguna yang login.

## 4. Android/iOS
Setelah web build siap:
- `npm install`
- `npx cap add android`
- `npx cap add ios` (macOS)
- `npx cap sync`
- buka Android Studio/Xcode, set signing, icons, splash, permissions, dan build release.

## 5. Produksi
Sebelum publikasi, tambahkan:
- payment gateway Indonesia (mis. Midtrans/Xendit) melalui backend/Edge Function,
- notifikasi push,
- chat realtime,
- verifikasi penjual,
- admin dashboard,
- moderasi dan pelaporan,
- kebijakan privasi & syarat layanan final.

Jangan masukkan service_role key ke aplikasi.
