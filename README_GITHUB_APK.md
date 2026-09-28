# MMC PONSEL — Build APK otomatis dari HP

Paket ini sudah memiliki GitHub Actions. Setelah seluruh isi paket di-upload ke repository GitHub, workflow akan membuat APK Android otomatis.

## Dari HP Android
1. Buat repository GitHub baru, misalnya `mmc-ponsel`.
2. Upload seluruh isi paket ini ke repository (termasuk folder `.github/workflows/`).
3. Buka tab **Actions**.
4. Pilih **Build MMC PONSEL APK**.
5. Jika belum berjalan otomatis, tekan **Run workflow**.
6. Tunggu sampai job selesai dengan status hijau.
7. Buka hasil workflow tersebut dan bagian **Artifacts**.
8. Download **MMC-PONSEL-APK**.
9. Ekstrak ZIP artifact dan ambil `app-debug.apk`.
10. Buka APK di Android untuk memasang aplikasi.

Workflow menggunakan GitHub Actions untuk menjalankan build di runner Ubuntu dan menyimpan APK sebagai artifact. Artifact dapat diunduh dari halaman hasil workflow.

## Catatan
- Ini menghasilkan **debug APK** untuk pengujian/pemasangan langsung.
- Untuk Google Play Store, diperlukan build release, signing key/keystore, dan konfigurasi publikasi yang terpisah.
- Jangan memasukkan password, service-role key Supabase, atau private signing key ke repository.
