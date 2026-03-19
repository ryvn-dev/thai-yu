"""
泰語高頻詞中文釋義表 v1
從 assets/data/thai_zh_glosses.json 載入，單一數據源。
"""
import json
from pathlib import Path

_JSON_PATH = Path(__file__).resolve().parent.parent.parent / "assets" / "data" / "thai_zh_glosses.json"

with open(_JSON_PATH, encoding="utf-8") as _f:
    THAI_ZH_GLOSSES: dict[str, str] = json.load(_f)
