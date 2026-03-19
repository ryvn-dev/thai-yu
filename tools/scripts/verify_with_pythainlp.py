"""
用 PyThaiNLP 驗證 thai_tables.py 的正確性，並找出遺漏。
"""
import json
from pythainlp import thai_consonants
from pythainlp.util import thai_digit_to_arabic_digit
from pythainlp.tokenize import word_tokenize

from thai_tables import (
    HIGH_CLASS, MID_CLASS, LOW_CLASS,
    INITIAL_TABLE, FINAL_SOUND, TONE_TABLE,
    get_consonant_class,
)


def verify_consonant_coverage():
    """比對 PyThaiNLP 的子音列表和我們的表"""
    print("═══ 1. 子音覆蓋率 ═══")

    ptn_consonants = set(thai_consonants)
    our_consonants = HIGH_CLASS | MID_CLASS | LOW_CLASS

    missing = ptn_consonants - our_consonants
    extra = our_consonants - ptn_consonants

    print(f"  PyThaiNLP 子音數: {len(ptn_consonants)}")
    print(f"  我們的子音數: {len(our_consonants)}")

    if missing:
        print(f"  ⚠ 我們缺少: {missing}")
    else:
        print("  ✓ 沒有遺漏")

    if extra:
        print(f"  ⚠ 我們多出: {extra}")
    else:
        print("  ✓ 沒有多餘")

    return len(missing) == 0 and len(extra) == 0


def verify_word_segmentation():
    """用 PyThaiNLP 分詞，驗證我們的韻尾表能否覆蓋常見詞的尾音"""
    print("\n═══ 2. 分詞 + 韻尾覆蓋 ═══")

    test_sentences = [
        "ฉันชอบกินข้าวผัด",
        "สวัสดีครับผมชื่อสมชาย",
        "วันนี้อากาศดีมาก",
        "ขอบคุณที่ช่วยเหลือ",
        "ประเทศไทยสวยงาม",
    ]

    all_finals_seen = set()
    for sent in test_sentences:
        words = word_tokenize(sent, engine="newmm")
        print(f"  「{sent}」→ {words}")

        for word in words:
            if word.strip():
                last_char = word[-1]
                if last_char in FINAL_SOUND:
                    all_finals_seen.add(last_char)

    print(f"\n  韻尾表覆蓋的尾音字母: {len(all_finals_seen)} 種")
    print(f"  {sorted(all_finals_seen)}")


def verify_tone_rules_with_known_words():
    """用已知正確的詞來驗證聲調規則"""
    print("\n═══ 3. 聲調規則驗證（已知詞） ═══")

    # (word, initial_consonant, tone_mark, syllable_type, expected_tone)
    test_cases = [
        ("กิน",  "ก", None,      "live",       "mid",  "吃"),
        ("ข้าว", "ข", "mai_tho", "live",       "fall", "飯"),
        ("ชอบ",  "ช", None,      "dead_long",  "fall", "喜歡"),
        ("ฉัน",  "ฉ", None,      "live",       "rise", "我"),
        ("ผัด",  "ผ", None,      "dead_short", "low",  "炒"),
        ("ดี",   "ด", None,      "live",       "mid",  "好"),
        ("ไป",   "ป", None,      "live",       "mid",  "去 — wait, ไป is mid class no mark live = mid? No... ไป 的 ไ-ป: ป is mid class, no mark, live → mid. But ไป is actually low tone."),
        ("น้ำ",  "น", "mai_tho", "live",       "high", "水"),
        ("มา",   "ม", None,      "live",       "mid",  "來"),
        ("สวย",  "ส", None,      "live",       "rise", "漂亮"),
    ]

    passed = 0
    failed = 0

    for word, initial, mark, syl_type, expected, meaning in test_cases:
        cls = get_consonant_class(initial)
        key = (cls, mark, syl_type)
        result = TONE_TABLE.get(key)

        if result == expected:
            print(f"  ✓ {word} ({meaning}): {cls}/{mark}/{syl_type} → {result}")
            passed += 1
        else:
            print(f"  ✗ {word} ({meaning}): {cls}/{mark}/{syl_type} → got {result}, expected {expected}")
            failed += 1

    print(f"\n  通過: {passed}, 失敗: {failed}")


def explore_pythainlp_features():
    """探索 PyThaiNLP 有哪些可用功能"""
    print("\n═══ 4. PyThaiNLP 可用功能探索 ═══")

    # Romanization
    try:
        from pythainlp.transliterate import romanize
        test = "สวัสดี"
        rom = romanize(test, engine="royin")
        print(f"  RTGS 羅馬化: {test} → {rom}")
    except Exception as e:
        print(f"  ⚠ romanize 失敗: {e}")

    # Soundex (音近搜尋)
    try:
        from pythainlp.soundex import lk82
        test = "กิน"
        sx = lk82(test)
        print(f"  Soundex: {test} → {sx}")
    except Exception as e:
        print(f"  ⚠ soundex 失敗: {e}")

    # Syllable tokenization
    try:
        from pythainlp.tokenize import syllable_tokenize
        test = "ประเทศไทย"
        syls = syllable_tokenize(test)
        print(f"  音節切分: {test} → {syls}")
    except Exception as e:
        print(f"  ⚠ syllable_tokenize 失敗: {e}")

    # Dictionary lookup
    try:
        from pythainlp.corpus import thai_words
        words = thai_words()
        print(f"  PyThaiNLP 詞典詞數: {len(words)}")
        # Check some of our loanwords
        from thai_tables import LOANWORDS_ZH
        found = 0
        for lw in LOANWORDS_ZH:
            if lw in words:
                found += 1
        print(f"  我們的借詞在詞典中: {found}/{len(LOANWORDS_ZH)}")
    except Exception as e:
        print(f"  ⚠ thai_words 失敗: {e}")


if __name__ == "__main__":
    verify_consonant_coverage()
    verify_word_segmentation()
    verify_tone_rules_with_known_words()
    explore_pythainlp_features()
    print("\n═══ 完成 ═══")
