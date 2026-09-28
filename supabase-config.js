// Isi dua nilai ini dari Supabase Dashboard > Project Settings > API.
// Jangan pernah menaruh service_role key di aplikasi. Gunakan Publishable/anon key saja.
window.MMC_SUPABASE_URL = "https://YOUR-PROJECT.supabase.co";
window.MMC_SUPABASE_ANON_KEY = "YOUR-PUBLISHABLE-OR-ANON-KEY";
window.MMC_SUPABASE_READY = !window.MMC_SUPABASE_URL.includes("YOUR-PROJECT") &&
  !window.MMC_SUPABASE_ANON_KEY.includes("YOUR-PUBLISHABLE");
window.MMC_SUPABASE = window.MMC_SUPABASE_READY
  ? supabase.createClient(window.MMC_SUPABASE_URL, window.MMC_SUPABASE_ANON_KEY)
  : null;
