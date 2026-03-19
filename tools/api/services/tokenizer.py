import re
import sys
from pathlib import Path

_scripts_dir = str(Path(__file__).resolve().parent.parent.parent / "scripts")
if _scripts_dir not in sys.path:
    sys.path.insert(0, _scripts_dir)

from pythainlp.tokenize import sent_tokenize, word_tokenize
from pythainlp.transliterate import pronunciate, romanize

_STRIP_CHARS = "\u0e3a"  # pinthu (ฺ)


def _clean_pron_syllable(syl: str) -> str:
    return syl.replace(_STRIP_CHARS, "")


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
            return syls
    except Exception:
        pass
    return [text]


def romanize_word(word: str) -> str:
    """RTGS romanization based on actual pronunciation."""
    try:
        syls = tokenize_syllables(word)
        parts = [romanize(s, engine="royin") for s in syls]
        return "".join(parts)
    except Exception:
        return romanize(word, engine="royin")
