"""Test gloss lookup integration."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "scripts"))

from api.services.tone_analyzer import analyze_word


def test_known_word_has_gloss():
    w = analyze_word("กิน")
    assert w.gloss == "吃"


def test_known_word_sawatdi():
    w = analyze_word("สวัสดี")
    assert w.gloss == "你好"


def test_unknown_word_fallback():
    """Pure nonsense should return '…', compound may split."""
    from thai_glosses import lookup_gloss

    assert lookup_gloss("xyzabc") == "…"


def test_compound_split_fallback():
    """Unknown compound words should split into known sub-words."""
    from thai_glosses import lookup_gloss

    result = lookup_gloss("ถ้อยคำ")
    assert result != "…"


def test_gloss_bundle_size():
    from thai_glosses import THAI_ZH_GLOSSES

    assert len(THAI_ZH_GLOSSES) >= 400
