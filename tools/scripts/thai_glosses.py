"""
泰語高頻詞中文釋義表 v1
從 assets/data/thai_zh_glosses.json 載入，單一數據源。
"""
import json
from pathlib import Path

_JSON_PATH = Path(__file__).resolve().parent.parent.parent / "assets" / "data" / "thai_zh_glosses.json"

with open(_JSON_PATH, encoding="utf-8") as _f:
    THAI_ZH_GLOSSES: dict[str, str] = json.load(_f)


def lookup_gloss(word: str) -> str:
    """Look up gloss with greedy compound split fallback."""
    exact = THAI_ZH_GLOSSES.get(word)
    if exact is not None:
        return exact
    # Greedy longest-match split
    parts: list[str] = []
    pos = 0
    while pos < len(word):
        best_gloss = None
        best_len = 0
        for length in range(len(word) - pos, 0, -1):
            candidate = word[pos:pos + length]
            gloss = THAI_ZH_GLOSSES.get(candidate)
            if gloss is not None:
                best_gloss = gloss
                best_len = length
                break
        if best_gloss:
            parts.append(best_gloss)
            pos += best_len
        else:
            pos += 1
    return "+".join(parts) if parts else "…"
