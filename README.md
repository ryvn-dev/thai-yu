# 泰嶼 Thai Yu

Thai reading analysis tool for Chinese (Mandarin) speakers. Paste Thai text, get word-by-word breakdowns with tone colors, phoneme analysis, and Chinese glosses.

## What it does

1. **Paste Thai text** — any sentence, paragraph, or song lyrics
2. **See every word decomposed** — segmentation, RTGS romanization, Chinese meaning
3. **Tap a word** — full phoneme breakdown (onset/vowel/coda) with IPA, Chinese approximations, and tone reasoning
4. **Per-syllable tone coloring** — 5 tones mapped to 5 colors across the entire UI
5. **TTS playback** — hear whole sentences or individual syllables at adjustable speed

## Architecture

```
Thai text
  → FastAPI backend (PyThaiNLP segmentation + 34K Thai-Chinese glossary)
  → Deterministic tone engine (consonant class × tone mark × syllable type)
  → Drift/SQLite cache (SHA-256 key)
  → Flutter UI (Material 3, Riverpod)
```

**Backend is the single source of truth** for segmentation, glosses, and syllable analysis. The Flutter app only computes tones (deterministic rule table) and renders results.

## Screens

| Route | Screen | Description |
|-------|--------|-------------|
| `/` | Home | Text input, recent analyses, quick links |
| `/result` | Result | Sentence view + learn mode toggle |
| `/tones` | Tone Guide | 5-tone reference with Mandarin mnemonics |
| `/consonants` | Consonant Guide | 44 consonants by class (high/mid/low) |
| `/history` | History | Searchable past analyses, swipe-to-delete |
| `/vocabulary` | Vocabulary | Saved words notebook |
| `/settings` | Settings | API key configuration |

## Setup

### Prerequisites

- Flutter SDK
- Python 3.11+ with [uv](https://docs.astral.sh/uv/)

### Backend

```bash
cd tools
uv sync
uv run uvicorn api.main:app --reload
# Runs on http://127.0.0.1:8000
```

### Frontend

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Tech stack

**Frontend**: Flutter, Riverpod 2.x, go_router, Drift (SQLite), freezed + json_serializable

**Backend**: FastAPI, PyThaiNLP, 34K-entry Thai-Chinese glossary (`assets/data/thai_zh_glosses.json`)

**Tone engine**: Deterministic rule table — never delegated to AI. 3 variables (consonant class, tone mark, syllable type) → 1 of 5 tones.
