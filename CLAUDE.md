# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

泰嶼 (Thai Yu) — a Thai reading analysis tool for Chinese speakers. User pastes Thai text → OpenAI segments & describes → tone rule engine computes tones → interactive 4-layer word display with tone colors.

## Commands

```bash
# Install dependencies
flutter pub get

# Run on device/simulator (no env file needed for basic use)
flutter run

# Code generation (Riverpod providers, freezed models, drift, JSON serialization)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs  # continuous

# Localization (auto-runs on build, or manually)
flutter gen-l10n

# Analysis and tests
flutter analyze
flutter test
flutter test test/widget_test.dart  # single test file
```

## Architecture

Feature-first architecture with four features: `analysis/` (result display, tone guide, consonant guide), `home/` (input + recent), `history/` (past analyses), `vocabulary/` (saved words), and `settings/` (API key).

**Initialization flow**: `main.dart` creates a `ProviderContainer`, calls `bootstrap()` for async setup (Supabase), then wraps the app in `UncontrolledProviderScope`.

**Routing**: go_router with 7 routes, no shell route or bottom nav:
- `/` → HomeScreen (input + recent analyses)
- `/result` → ResultScreen (sentence view / learn mode)
- `/tones` → ToneGuideScreen (5-tone reference)
- `/consonants` → ConsonantGuideScreen (44 consonants by class)
- `/history` → HistoryScreen (searchable, swipe-to-delete)
- `/vocabulary` → VocabularyScreen (saved words)
- `/settings` → SettingsScreen (API key)

**Tone rule engine**: Thai tones are determined by a deterministic rule table in `lib/data/models/tone_rules.dart`, based on 3 variables: consonant class × tone mark × syllable type. The backend provides these variables; the app computes the final tone. Never delegate tone determination to AI.

**Data flow**: FastAPI backend (分詞 + 詞義 + 音節分析) → tone rule engine (聲調) → cache (drift/SQLite, SHA-256 key) → UI rendering.

**Backend (SSOT)**: Python FastAPI in `tools/api/`, managed by `uv`. The backend is the single source of truth for segmentation, glosses (34K Thai-Chinese glossary), and syllable analysis. Frontend only displays what the backend returns.
- Start: `cd tools && uv run uvicorn api.main:app --reload`
- Endpoints: `POST /analyze` (core), `POST /tokenize`, `GET /health`
- Core engine: `tools/api/services/tone_analyzer.py` (PyThaiNLP + deterministic tone rules)
- Static data: `tools/scripts/thai_tables.py` (consonant classes, vowels, finals, clusters)
- Glossary: `assets/data/thai_zh_glosses.json` (read by backend only, not bundled in Flutter)

## Key Patterns

**Riverpod code generation** (v2.x): Use `@riverpod` annotation with **generated Ref types** (e.g., `RouterRef`), not bare `Ref`. Use `@Riverpod(keepAlive: true)` for singletons. Generated files use `part 'filename.g.dart'`.

**Data models**: Use `freezed` + `json_serializable` for immutable models with `copyWith` and JSON support.

**Localization**: ARB files in `lib/config/l10n/`. English is the template. Import as `import 'config/l10n/app_localizations.dart'` (not `flutter_gen`).

**Theme**: Material 3 with warm earthy palette (`AppColors`), `AppTextStyles` (DM Sans for UI, Noto Serif Thai for Thai text, DM Mono for romanization), `AppSpacing`. Light/dark variants in `AppTheme`.

**Tone colors**: Five tones × five colors defined in `AppColors` and `ToneType` enum. SVG contour curves in `ToneType.svgPath`.

**Analysis**: Strict mode enabled (strict-casts, strict-inference, strict-raw-types). Prefer const, require trailing commas, prefer single quotes.

## Git Flow

**Do NOT add Co-Authored-By to commit messages.**

**Branches**: Use prefixes based on purpose:
- `feat/<name>` — new features
- `fix/<name>` — bug fixes
- `refactor/<name>` — code restructuring
- `chore/<name>` — tooling, deps, config

**Commits**: Use conventional commit format. Keep messages concise, in English, focused on "why" not "what".
- `feat: add vocabulary flashcard screen`
- `fix: resolve auth redirect loop on expired session`
- `refactor: extract lesson repository interface`
- `chore: upgrade riverpod to 2.7`

**Workflow**: Create feature branch from `main` → work → PR back to `main`. One logical change per commit. Run `flutter analyze` and `flutter test` before committing.
