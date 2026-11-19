# JAILBREAK HERMES FULL v3

**One-click jailbreak Hermes Agent — self-contained, dynamic, no download.**

Sekali run → menu interaktif → Hermes langsung zero-refusal + skill arsenal
ter-install. Skills **sudah di-bundle** di folder ini (`skills-bundle/`) — user
**tidak perlu clone/download apa pun**. Semua path **auto-detect per OS**, bisa
di-custom lewat `.env` atau menu interaktif.

Cross-platform: **Windows / Ubuntu / Linux / macOS** — PC lokal, RDP, VPS.
Zero dependency: **pure Python 3 stdlib** (ga ada `pip install`).

---

## Quick Start (user baru)

```
1. Clone / extract folder ini
2. cp .env.example .env          # (Windows: copy .env.example .env)
3. Double-click jailbreak.bat    # (Linux/Mac: ./jailbreak.sh)
4. Pilih 1 (Run sekarang)
5. Selesai — Hermes ready
```

Script akan:
1. **Auto-detect** Hermes home (`%LOCALAPPDATA%\hermes` / `~/.hermes`), router 9Router, API key dari DB 9Router
2. Tanya **model mana** yang mau di-test (list dari router + auto-pick kandidat uncensored)
3. Menjalankan 5 langkah (di bawah), **auto-save** pilihan lo ke `.env`
4. Menulis `REPORT.md` (agent-readable run report)

Kalau auto-detect meleset (Hermes di path custom / router bukan 9Router),
pilih **menu 2 (Konfigurasi)** — tinggal isi, langsung ke-save ke `.env`.
Run berikutnya pakai config itu, ga ditanya lagi.

## Apa yang di-run (5 langkah)

| # | Step | Fungsi |
|---|------|--------|
| 1/5 | **SYNC** | Load `skills-bundle/` (skill arsenal: godmode, bug-bounty, web-exploit, ctf, dll) → Hermes skills dir. Idempotent — yang ada di-skip, ga ngapa-ngapain skill lain |
| 2/5 | **BACKUP** | `SOUL.md` → `backups/SOUL.md.bak-<timestamp>` |
| 3/5 | **APPLY** | Inject section **ZERO-REFUSAL PROTOCOL** ke `SOUL.md` (idempotent, marker-guarded) |
| 4/5 | **PURGE** | Hapus refusal messages dari `state.db` (regex config-able) |
| 5/5 | **TEST** | Kirim stack jailbreak L4_MAX_STACK ke model router → klasifikasi `PASSED / REFUSED / HEDGED / EMPTY`, retry otomatis, evidence ke JSON |

## Interactive Menu

```
Pilihan:
   1. Run sekarang (full: sync+skills+apply+purge+test)
   2. Konfigurasi (ubah path/router/model, disimpan ke .env)
   3. List model router
   4. Dry-run (preview tanpa perubahan)
   5. Restore SOUL.md dari backup terakhir
   q. Keluar
```

**Auto-pick model:** kalau ga mau milih manual, Enter di prompt model →
script ambil list model dari router, filter kandidat uncensored
(prefix `ismr`/`uncens`/`unc`/`god`/`unfilter`), ambil maks 5. Hasil
dike-save ke `.env` (`TEST_MODELS=`) jadi run berikutnya ga ditanya lagi.

## Konfigurasi (.env)

Semua **optional** — kosong = auto-detect. Template lengkap: `.env.example`.

| Key | Default | Fungsi |
|-----|---------|--------|
| `HERMES_HOME` | auto-detect | Path folder Hermes |
| `SOUL_FILE` / `STATE_DB` | `SOUL.md` / `state.db` | Nama file |
| `MODE` | `append` | `append` = tambah doctrine (aman) · `full` = replace SOUL.md dgn SOUL framework |
| `BACKUP_DIR` | `./backups` | Folder backup SOUL.md |
| `SYAD_DIR` | auto-detect | Install dir SYADAGENTIC (dipakai `MODE=full`) |
| `REPO_DIR` | auto-detect | Repo git SYADAGENTIC (opsional, utk update bundle) |
| `SYNC_SKILLS` | `1` | Load skills-bundle ke Hermes tiap run |
| `SKIP_EXISTING` | `1` | Skill yang sudah ada ga di-overwrite |
| `OVERWRITE_SKILLS` | `0` | `1` = refresh semua skill dari bundle |
| `GIT_PULL` | `0` | `1` = git pull repo + refresh bundle (butuh internet) |
| `ROUTER_URL` | `http://127.0.0.1:20128/v1` | Base URL router OpenAI-compatible |
| `ROUTER_KEY` | auto-detect | API key (auto dari DB 9Router) |
| `TEST_MODELS` | kosong = auto-pick | Model yang di-test (koma-pisah) |
| `PICK_MODELS` | `1` | Tanya pilihan model tiap run |
| `AUTO_TEST_MODELS` | `1` | Auto-detect model uncensored dari router |
| `RETRY_EMPTY` / `RETRY_WAIT` | `2` / `10` | Retry kalau `EMPTY` (rate-limit) |
| `MAX_TOKENS` | `900` | L4 stack butuh >= 900 |
| `TIMEOUT` | `180` | Timeout per request (detik) |
| `JB_TEST` | `1` | Test JB setelah apply |
| `REFUSAL_PATTERNS` | (lihat .env) | Regex refusal utk purge + klasifikasi |

## CLI Flags (advanced)

```
jailbreak.bat [--dry-run] [--config] [--list-models] [--restore] [--run]
jailbreak.sh  <flags sama>

--run            full run non-interaktif (pakai .env, buat cron/automation)
--dry-run        preview, ga ada yang ditulis
--config         cuma buka menu konfigurasi
--list-models    list model dari router
--restore        pulihin SOUL.md dari backup terbaru
```

## REPORT.md (agent-readable / GitHub docs)

Setiap run, script men-generate **`REPORT.md`** — laporan markdown yang bisa
dibaca langsung oleh agent (Hermes/Claude/Codex) atau dijadikan docs di GitHub:
metadata run (OS, Python, path, mode), tabel 5 langkah + status, hasil test JB
per model (class/latency/attempts), hasil skills sync, daftar evidence files.
Auto-overwrite tiap run; di-gitignore — `git add -f REPORT.md` kalau mau
ditampilkan di repo.

## Self-contained: skills-bundle/

```
skills-bundle/
├── ai/                (red-team, adversarial-ml, agent-hijack...)
├── bug-bounty/        (sql-injection, xss, ssrf, rce, subdomain...)
├── ctf/               (pwn, crypto, web, forensics...)
├── devops/            (hermes-guardrail-bypass, windows-privesc...)
└── security/          (godmode, web-exploit, malware-analysis...)
```

~68 skill, ~8 MB. Sudah termasuk di repo — **user tinggal run**. Update konten
bundle: set `REPO_DIR` + `GIT_PULL=1` (otomatis sync dari repo SYADAGENTIC),
atau `OVERWRITE_SKILLS=1` setelah isi ulang folder `skills-bundle/`.

## Klasifikasi hasil test

- `PASSED` — full detail, no disclaimer ✅
- `HEDGED` — jawab tapi pake substitusi (demo code, bukan artifact beneran)
- `REFUSED` — nolak (regex: "can't / won't / as an AI / safety guidelines...")
- `EMPTY` — ga ada output (rate-limit free tier / quota node — bukan refusal)
- `ERROR ...` — error transport (baca nama error-nya)

## Privacy / Clean Repo

Repo **clean dari data pribadi** — yang ke-push:

```
jailbreak_hermes.py  .env.example  jailbreak.bat  jailbreak.sh
README.md            .gitignore    skills-bundle/
```

Di-gitignore (local only): `.env` (isi settingan lokal), `REPORT.md`,
`sync_manifest.json`, `jb_test_*.json`, `backups/`, `__pycache__/`.

Langkah upload:
```
cd "Jailbreak Hermes Full"
git init && git add -A && git commit -m "v3: self-contained, interactive, bundled skills"
git remote add origin <url> && git push -u origin main
```

## Notes

- **Idempotent** — aman di-run berkali-kali; ga ada duplikat doctrine, ga ada skill dobel.
- **Rate-limit:** model free tier sering `EMPTY`/`REFUSED` kalau ditembak
  beruntun — retry otomatis sudah ada, tapi hasil test bisa berubah antar run.
  Itu kondisi provider, bukan stack lemah.
- **Model bandel:** beberapa model butuh rebuttal loop multi-turn (recipe ada
  di doctrine SOUL.md) — test 1-shot di script ini sengaja simpel.
- **Restore:** `jailbreak.bat --restore` (atau menu 5) pulihkan SOUL.md dari
  backup terakhir. Semua backup di folder `backups/`.
