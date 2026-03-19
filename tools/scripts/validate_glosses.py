"""驗證 thai_glosses.py 的所有詞彙。"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from pythainlp.corpus import thai_words
from thai_glosses import THAI_ZH_GLOSSES

def main():
    words = thai_words()
    errors = []
    warnings = []

    for thai, zh in THAI_ZH_GLOSSES.items():
        if not zh or zh.strip() == "":
            errors.append(f"空釋義: {thai}")
        if thai not in words:
            warnings.append(f"不在 thai_words() 中: {thai} ({zh})")

    print(f"總計: {len(THAI_ZH_GLOSSES)} 詞")
    print(f"錯誤: {len(errors)}")
    print(f"警告: {len(warnings)}")

    if errors:
        print("\n── 錯誤 ──")
        for e in errors:
            print(f"  ✗ {e}")

    if warnings:
        print("\n── 警告（複合詞/借詞可能不在基礎詞表中）──")
        for w in warnings:
            print(f"  ⚠ {w}")

    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
