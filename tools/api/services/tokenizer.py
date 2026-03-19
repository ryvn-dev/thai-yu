import re
import sys
from pathlib import Path

_scripts_dir = str(Path(__file__).resolve().parent.parent.parent / "scripts")
if _scripts_dir not in sys.path:
    sys.path.insert(0, _scripts_dir)

from pythainlp.tokenize import sent_tokenize, word_tokenize
from pythainlp.transliterate import pronunciate, romanize

from thai_tables import HIGH_CLASS, HO_NAM_PAIRS, LOW_CLASS, MID_CLASS, get_ho_nam_real_consonant

_STRIP_CHARS = "\u0e3a"  # pinthu (ฺ)

# Low-class consonants that pair with ห in ห นำ
_HO_NAM_SECONDS = {pair[1] for pair in HO_NAM_PAIRS}  # ม น ง ว ล ร ย ญ ณ


def _clean_pron_syllable(syl: str) -> str:
    return syl.replace(_STRIP_CHARS, "")


def _fix_split_ho_nam(syls: list[str]) -> list[str]:
    """Fix pronunciate splitting ห นำ across syllables.

    e.g. ['เห', 'มือน'] → ['เหมือน']  (เหมือน is ห นำ + ม)
    """
    if len(syls) <= 1:
        return syls

    result: list[str] = []
    i = 0
    while i < len(syls):
        syl = syls[i]
        # Check: current syllable ends with ห, next syllable starts with ห นำ partner
        if (
            i + 1 < len(syls)
            and syl.endswith("ห")
            and syls[i + 1]
            and syls[i + 1][0] in _HO_NAM_SECONDS
        ):
            # Merge: เห + มือน → เหมือน
            result.append(syl + syls[i + 1])
            i += 2
        else:
            result.append(syl)
            i += 1
    return result


def tokenize_sentences(text: str) -> list[str]:
    """Split text into sentences.

    Strategy:
    1. Split on user's natural breaks (newlines)
    2. Within each line, use PyThaiNLP sent_tokenize for semantic splitting
    """
    lines = text.strip().split("\n")
    sentences: list[str] = []

    for line in lines:
        line = line.strip()
        if not line:
            continue
        # sent_tokenize works well when text has spaces
        sents = sent_tokenize(line)
        for s in sents:
            s = s.strip()
            if s:
                sentences.append(s)

    return sentences


def tokenize_words(text: str) -> list[str]:
    """Segment Thai text into words using PyThaiNLP."""
    tokens = word_tokenize(text.strip(), engine="newmm")
    return [t for t in tokens if t.strip()]


def tokenize_syllables(text: str) -> list[str]:
    """Split a word into pronunciation-based syllables."""
    try:
        pron = pronunciate(text)
        syls = [_clean_pron_syllable(s.strip()) for s in pron.split("-") if s.strip()]
        if syls:
            return _fix_split_ho_nam(syls)
    except Exception:
        pass
    return [text]


def _strip_ho_nam_for_romanize(syl: str) -> str:
    """Remove silent ห from ห นำ syllable before romanization.

    e.g. เหมือน → เมือน, หมา → มา
    """
    real = get_ho_nam_real_consonant(syl)
    if real is None:
        return syl
    # Find ห position and remove it
    _all = HIGH_CLASS | MID_CLASS | LOW_CLASS
    for i, c in enumerate(syl):
        if c == "ห" and c in _all:
            return syl[:i] + syl[i + 1:]
    return syl


# PyThaiNLP romanize sometimes fails to convert certain Thai chars.
# Map leftover Thai vowel chars to their RTGS equivalents.
_THAI_CHAR_FALLBACK = {
    "า": "a", "ะ": "a", "ิ": "i", "ี": "i", "ึ": "ue", "ื": "ue",
    "ุ": "u", "ู": "u", "เ": "e", "แ": "ae", "โ": "o", "ใ": "ai",
    "ไ": "ai", "ำ": "am", "็": "", "์": "", "่": "", "้": "",
    "๊": "", "๋": "", "ั": "a",
}


def _romanize_syllable(syl: str) -> str:
    """Romanize a single syllable, fixing PyThaiNLP issues."""
    stripped = _strip_ho_nam_for_romanize(syl)
    # Strip ็ (mai taikhu) — PyThaiNLP can't romanize it
    stripped = stripped.replace("็", "")
    rom = romanize(stripped, engine="royin")

    # Fix PyThaiNLP bug: ห as real /h/ initial gets dropped
    if stripped == syl:  # not stripped = not ห นำ
        _all = HIGH_CLASS | MID_CLASS | LOW_CLASS
        consonants = [c for c in syl if c in _all]
        if consonants and consonants[0] == "ห" and not rom.startswith("h"):
            rom = "h" + rom

    # Fix leftover Thai chars that romanize failed to convert
    result = []
    for c in rom:
        if "\u0e00" <= c <= "\u0e7f":
            result.append(_THAI_CHAR_FALLBACK.get(c, ""))
        else:
            result.append(c)
    return "".join(result)


def romanize_word(word: str) -> str:
    """RTGS romanization based on actual pronunciation."""
    try:
        syls = tokenize_syllables(word)
        parts = [_romanize_syllable(s) for s in syls]
        return "".join(parts)
    except Exception:
        return romanize(word, engine="royin")
