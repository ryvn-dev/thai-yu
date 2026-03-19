# thai_tables.py
# 所有靜態資料表，不依賴任何外部套件
# 這些表是封閉規則，永遠不需要 AI

# ── 聲母分類 ──────────────────────────────────────────────────
# 高類輔音 (อักษรสูง)
HIGH_CLASS = set("ข ฃ ฉ ฐ ถ ผ ฝ ศ ษ ส ห".split())

# 中類輔音 (อักษรกลาง)
MID_CLASS = set("ก จ ด ต ฎ ฏ บ ป อ".split())

# 低類輔音 (อักษรต่ำ) — 剩餘全部
LOW_CLASS = set("ง ญ ณ น ม ย ร ล ว ค ฅ ฆ ช ซ ฌ ฑ ฒ ท ธ พ ฟ ภ ฬ ฮ".split())

def get_consonant_class(char):
    if char in HIGH_CLASS: return "high"
    if char in MID_CLASS:  return "mid"
    return "low"

# ── ห นำ（引導型 ห）—— 改變低類輔音的類別為高類 ──────────────
# หม หน หง หว หล หร หย หญ หณ
HO_NAM_PAIRS = {
    "หม", "หน", "หง", "หว", "หล", "หร", "หย", "หญ",
}

# อ นำ — อ promotes ย to mid class (only in these 4 words)
O_NAM_PAIRS = {"อย"}

# ── 聲調符號 ──────────────────────────────────────────────────
TONE_MARKS = {
    "่": "mai_ek",
    "้": "mai_tho",
    "๊": "mai_tri",
    "๋": "mai_chattawa",
}

# ── 複聲母 (Consonant Clusters) ─────────────────────────────────
# 泰語複聲母第二個字母只能是 ร, ล, ว
CONSONANT_CLUSTERS = {
    "กร", "กล", "กว",
    "ขร", "ขล", "ขว",
    "คร", "คล", "คว",
    "ตร",
    "ปร", "ปล",
    "พร", "พล",
    # 以下為借詞複聲母（非原生泰語，但實際使用中存在）
    "ผล",
    "บร", "บล",
    "ฟร", "ฟล",
    "สร",
}

CLUSTER_TABLE = {
    "กร": {"ipa": "/kr/",  "zh": "不送氣，像「格」+ 彈舌 r"},
    "กล": {"ipa": "/kl/",  "zh": "不送氣，像「格」+ l"},
    "กว": {"ipa": "/kw/",  "zh": "不送氣，像「瓜」的 kw-"},
    "ขร": {"ipa": "/kʰr/", "zh": "送氣，像「可」+ 彈舌 r"},
    "ขล": {"ipa": "/kʰl/", "zh": "送氣，像「可」+ l"},
    "ขว": {"ipa": "/kʰw/", "zh": "送氣，像「可」+ w"},
    "คร": {"ipa": "/kʰr/", "zh": "送氣，像「可」+ 彈舌 r"},
    "คล": {"ipa": "/kʰl/", "zh": "送氣，像「可」+ l"},
    "คว": {"ipa": "/kʰw/", "zh": "送氣，像「可」+ w"},
    "ตร": {"ipa": "/tr/",  "zh": "不送氣，像「特」+ 彈舌 r"},
    "ปร": {"ipa": "/pr/",  "zh": "不送氣，像「怕」不送氣 + 彈舌 r"},
    "ปล": {"ipa": "/pl/",  "zh": "不送氣，像「怕」不送氣 + l"},
    "พร": {"ipa": "/pʰr/", "zh": "送氣，像「坡」+ 彈舌 r"},
    "พล": {"ipa": "/pʰl/", "zh": "送氣，像「坡」+ l"},
    "ผล": {"ipa": "/pʰl/", "zh": "送氣，像「坡」+ l"},
    "บร": {"ipa": "/br/",  "zh": "像「爸」+ 彈舌 r"},
    "บล": {"ipa": "/bl/",  "zh": "像「爸」+ l"},
    "ฟร": {"ipa": "/fr/",  "zh": "像「飛」+ 彈舌 r"},
    "ฟล": {"ipa": "/fl/",  "zh": "像「飛」+ l"},
    "สร": {"ipa": "/sr/",  "zh": "像「斯」+ 彈舌 r（常簡化為 /s/）"},
}

def is_cluster(c1: str, c2: str) -> bool:
    """判斷兩個輔音是否構成合法複聲母"""
    return (c1 + c2) in CONSONANT_CLUSTERS

def get_cluster_info(c1: str, c2: str) -> dict | None:
    """取得複聲母的發音資訊"""
    return CLUSTER_TABLE.get(c1 + c2)

# ── 韻尾映射（8種音，不管是哪個字母） ──────────────────────────
FINAL_SOUND = {
    # /-k/ 喉塞音，停在喉嚨
    "ก": {"sound": "/-k/", "type": "stop", "zh": "停在喉嚨，不送氣"},
    "ข": {"sound": "/-k/", "type": "stop", "zh": "停在喉嚨，不送氣"},
    "ค": {"sound": "/-k/", "type": "stop", "zh": "停在喉嚨，不送氣"},
    "ฆ": {"sound": "/-k/", "type": "stop", "zh": "停在喉嚨，不送氣"},
    # /-p/ 雙唇塞音，停在嘴唇
    "บ": {"sound": "/-p/", "type": "stop", "zh": "停在嘴唇，幾乎不送氣"},
    "ป": {"sound": "/-p/", "type": "stop", "zh": "停在嘴唇，幾乎不送氣"},
    "พ": {"sound": "/-p/", "type": "stop", "zh": "停在嘴唇，幾乎不送氣"},
    "ภ": {"sound": "/-p/", "type": "stop", "zh": "停在嘴唇，幾乎不送氣"},
    "ฟ": {"sound": "/-p/", "type": "stop", "zh": "停在嘴唇，幾乎不送氣"},
    # /-t/ 舌尖塞音，停在舌尖
    "ด": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ต": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ถ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ท": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ธ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ฎ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ฏ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ฐ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ฑ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ฒ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ช": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ซ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ศ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ษ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ส": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ฌ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "จ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    "ฬ": {"sound": "/-n/", "type": "sonorant", "zh": "韻尾位置發 -n，同 ล"},
    "ฉ": {"sound": "/-t/", "type": "stop", "zh": "停在舌尖，幾乎不送氣"},
    # /-n/ 鼻音
    "น": {"sound": "/-n/", "type": "sonorant", "zh": "收 -n 尾，像「安」"},
    "ณ": {"sound": "/-n/", "type": "sonorant", "zh": "收 -n 尾，像「安」"},
    "ญ": {"sound": "/-n/", "type": "sonorant", "zh": "收 -n 尾，像「安」"},
    # /-m/ 鼻音
    "ม": {"sound": "/-m/", "type": "sonorant", "zh": "收 -m 尾，嘴唇閉合"},
    # /-ng/ 鼻音
    "ง": {"sound": "/-ng/", "type": "sonorant", "zh": "收 -ng 尾，像「行」的 ng"},
    # /-o/ 或 /-w/ 滑音
    "ว": {"sound": "/-o/ 或 /-w/", "type": "sonorant", "zh": "收尾滑音，嘴型收圓"},
    # /-i/ 或 /-y/ 滑音
    "ย": {"sound": "/-i/ 或 /-y/", "type": "sonorant", "zh": "收尾滑音，嘴型收窄"},
    # /-r/ (ร ในบางคำ)
    "ร": {"sound": "/-n/ 或靜音", "type": "sonorant", "zh": "特殊：部分詞裡 ร 韻尾發 -n 或靜音"},
    # /-l/
    "ล": {"sound": "/-n/", "type": "sonorant", "zh": "韻尾位置發 -n，不捲舌"},
}

# ── 韻母（元音）表 ──────────────────────────────────────────────
# 泰語元音可出現在輔音的上方、下方、前方、後方、環繞位置
# 單字符元音（出現在音節內）
VOWEL_CHARS = {
    # 上方 / 下方元音符號
    "ะ":  {"ipa": "/a/",   "zh": "短元音，像「啊」",         "long": False},
    "ั":  {"ipa": "/a/",   "zh": "短元音，像「啊」（短）",    "long": False},
    "า":  {"ipa": "/aː/",  "zh": "長元音，像「啊——」",       "long": True},
    "ิ":  {"ipa": "/i/",   "zh": "短元音，像「衣」",         "long": False},
    "ี":  {"ipa": "/iː/",  "zh": "長元音，像「衣——」",       "long": True},
    "ึ":  {"ipa": "/ɯ/",   "zh": "短元音，嘴平不圓，像悶哼",  "long": False},
    "ื":  {"ipa": "/ɯː/",  "zh": "長元音，嘴平不圓，像悶哼拉長", "long": True},
    "ุ":  {"ipa": "/u/",   "zh": "短元音，像「烏」",         "long": False},
    "ู":  {"ipa": "/uː/",  "zh": "長元音，像「烏——」",       "long": True},
    # 前置元音符號（寫在輔音前面，但發音在後面）
    "เ":  {"ipa": "/eː/",  "zh": "長元音，像「誒——」",       "long": True},
    "แ":  {"ipa": "/ɛː/",  "zh": "長元音，嘴張大，像「欸——」", "long": True},
    "โ":  {"ipa": "/oː/",  "zh": "長元音，像「哦——」",       "long": True},
    "ใ":  {"ipa": "/aj/",  "zh": "像「愛」，快速滑過",       "long": True},
    "ไ":  {"ipa": "/aj/",  "zh": "像「愛」，快速滑過",       "long": True},
    # 特殊
    "ำ":  {"ipa": "/am/",  "zh": "像「安姆」，a + m 合在一起", "long": False},
    # ็ (mai taikhu) 是短音標記，不是元音本身，在 tone_analyzer 中特殊處理
}

# 所有元音字符集合（用於從音節中提取）
VOWEL_CHAR_SET = set(VOWEL_CHARS.keys())

# ── 複合韻母表（環繞型/組合型） ──────────────────────────────────
# 泰語許多韻母由多個字符組合，分佈在輔音的前後或上下
# key = frozenset of vowel chars found in syllable
# 匹配規則：找到音節中所有元音字符，組成 frozenset 去查表
COMPOUND_VOWELS: dict[frozenset[str], dict] = {
    # เ-า = /aw/ (เข้า, เช้า, เจ้า)
    frozenset({"เ", "า"}):  {"ipa": "/aw/",  "zh": "像「奧」，a 滑向 w",      "long": True,  "display": "เ-า"},
    # เ-ีย = /ia/ (เรียน, เลีย, เสีย)
    frozenset({"เ", "ี"}):  {"ipa": "/ia/",  "zh": "像「衣啊」，i 滑向 a",     "long": True,  "display": "เ-ีย"},
    # เ-ือ = /ɯa/ (เสือ, เดือน, เรือ)
    frozenset({"เ", "ื"}):  {"ipa": "/ɯa/", "zh": "像悶哼滑向「啊」",          "long": True,  "display": "เ-ือ"},
    # เ-ิ = /ɤː/ (เดิน, เกิด, เลิก) — note: เ-ิ without อ
    frozenset({"เ", "ิ"}):  {"ipa": "/ɤː/", "zh": "像「餓」拉長，嘴微張",      "long": True,  "display": "เ-ิ"},
    # เ-ะ = /e/ short (เกะ, เละ, เตะ)
    frozenset({"เ", "ะ"}):  {"ipa": "/e/",   "zh": "短元音，像「誒」",          "long": False, "display": "เ-ะ"},
    # เ-าะ = /ɔ/ short (เกาะ, เบาะ)
    frozenset({"เ", "า", "ะ"}): {"ipa": "/ɔ/", "zh": "短元音，像「哦」嘴圓",   "long": False, "display": "เ-าะ"},
    # แ-ะ = /ɛ/ short (แกะ, แพะ)
    frozenset({"แ", "ะ"}):  {"ipa": "/ɛ/",   "zh": "短元音，嘴張大像「欸」",    "long": False, "display": "แ-ะ"},
    # โ-ะ = /o/ short (โกะ)
    frozenset({"โ", "ะ"}):  {"ipa": "/o/",   "zh": "短元音，像「哦」",          "long": False, "display": "โ-ะ"},
    # เ-อะ = /ɤ/ short (เลอะ) — อ is consonant, ะ is vowel + เ
    # Handled: เ+ะ in vowel set, but need to detect อ between them
    #   → handled in tone_analyzer special case
    # เ-อ = /ɤː/ long (เธอ, เจอ) — อ is consonant, handled in tone_analyzer
    # ัว = /ua/ (กลัว, วัว, ตัว) — ว is consonant, handled in tone_analyzer
}

def get_vowel_info(char):
    """查詢單個元音字符的資訊"""
    return VOWEL_CHARS.get(char)

# ── 聲調計算表（30格） ──────────────────────────────────────────
# key: (consonant_class, tone_mark, syllable_type)
# syllable_type: "live", "dead_short", "dead_long"
# 回傳: "mid" | "low" | "fall" | "high" | "rise"

TONE_TABLE = {
    # 中類輔音
    ("mid", None,         "live"):       "mid",
    ("mid", "mai_ek",     "live"):       "low",
    ("mid", "mai_tho",    "live"):       "fall",
    ("mid", "mai_tri",    "live"):       "high",
    ("mid", "mai_chattawa","live"):       "rise",
    ("mid", None,         "dead_short"): "low",
    ("mid", None,         "dead_long"):  "low",
    ("mid", "mai_ek",     "dead_short"): "low",
    ("mid", "mai_ek",     "dead_long"):  "low",
    ("mid", "mai_tho",    "dead_short"): "fall",
    ("mid", "mai_tho",    "dead_long"):  "fall",

    # 高類輔音
    ("high", None,         "live"):       "rise",
    ("high", "mai_ek",     "live"):       "low",
    ("high", "mai_tho",    "live"):       "fall",
    ("high", None,         "dead_short"): "low",
    ("high", None,         "dead_long"):  "low",
    ("high", "mai_ek",     "dead_short"): "low",
    ("high", "mai_ek",     "dead_long"):  "low",
    ("high", "mai_tho",    "dead_short"): "fall",
    ("high", "mai_tho",    "dead_long"):  "fall",

    # 低類輔音
    ("low", None,         "live"):       "mid",
    ("low", "mai_ek",     "live"):       "fall",
    ("low", "mai_tho",    "live"):       "high",
    ("low", None,         "dead_short"): "high",
    ("low", None,         "dead_long"):  "fall",
    ("low", "mai_ek",     "dead_short"): "fall",
    ("low", "mai_ek",     "dead_long"):  "fall",
    ("low", "mai_tho",    "dead_short"): "high",
    ("low", "mai_tho",    "dead_long"):  "high",
}

# ── 聲母發音 + 中文近似音（44個聲母全覆蓋） ────────────────────
INITIAL_TABLE = {
    "ก": {"rtgs": "k",   "ipa": "/k/",   "zh_approx": "不送氣，像「格」的 k，嘴巴不噴氣",         "cls": "mid"},
    "ข": {"rtgs": "kh",  "ipa": "/kʰ/",  "zh_approx": "送氣音，像「可」的 kh，嘴巴噴一口氣",      "cls": "high"},
    "ฃ": {"rtgs": "kh",  "ipa": "/kʰ/",  "zh_approx": "送氣音，同 ข，現代泰語已廢用",             "cls": "high"},
    "ค": {"rtgs": "kh",  "ipa": "/kʰ/",  "zh_approx": "送氣音，同 ข 的發音，像「可」",             "cls": "low"},
    "ฅ": {"rtgs": "kh",  "ipa": "/kʰ/",  "zh_approx": "送氣音，同 ค，現代已廢用",                 "cls": "low"},
    "ฆ": {"rtgs": "kh",  "ipa": "/kʰ/",  "zh_approx": "送氣音，同 ค，像「可」",                   "cls": "low"},
    "ง": {"rtgs": "ng",  "ipa": "/ŋ/",   "zh_approx": "像「行」的 ng 尾，但在字頭，粵語很常見",   "cls": "low"},
    "จ": {"rtgs": "ch",  "ipa": "/tɕ/",  "zh_approx": "不送氣，像「接」的 j，舌頭頂上顎",         "cls": "mid"},
    "ฉ": {"rtgs": "ch",  "ipa": "/tɕʰ/", "zh_approx": "送氣音，像「車」的 ch，氣流較強",           "cls": "high"},
    "ช": {"rtgs": "ch",  "ipa": "/tɕʰ/", "zh_approx": "送氣音，同 ฉ，像「車」但氣流輕柔一點",     "cls": "low"},
    "ซ": {"rtgs": "s",   "ipa": "/s/",   "zh_approx": "像「斯」的 s，清晰摩擦音",                  "cls": "low"},
    "ฌ": {"rtgs": "ch",  "ipa": "/tɕʰ/", "zh_approx": "送氣音，同 ช，較少用",                     "cls": "low"},
    "ญ": {"rtgs": "y",   "ipa": "/j/",   "zh_approx": "像「也」的 y，聲母位置",                    "cls": "low"},
    "ฎ": {"rtgs": "d",   "ipa": "/d/",   "zh_approx": "不送氣，像「得」的 d，捲舌版，現代泰語同 ด","cls": "mid"},
    "ฏ": {"rtgs": "t",   "ipa": "/t/",   "zh_approx": "不送氣，像「特」的 t，捲舌版，現代泰語同 ต","cls": "mid"},
    "ฐ": {"rtgs": "th",  "ipa": "/tʰ/",  "zh_approx": "送氣音，像「特」送氣，捲舌，同 ถ",          "cls": "high"},
    "ฑ": {"rtgs": "th",  "ipa": "/tʰ/",  "zh_approx": "送氣音，同 ท，捲舌",                       "cls": "low"},
    "ฒ": {"rtgs": "th",  "ipa": "/tʰ/",  "zh_approx": "送氣音，同 ท",                             "cls": "low"},
    "ณ": {"rtgs": "n",   "ipa": "/n/",   "zh_approx": "像「那」的 n，捲舌版，現代同 น",             "cls": "low"},
    "ด": {"rtgs": "d",   "ipa": "/d/",   "zh_approx": "不送氣，像「得」的 d",                      "cls": "mid"},
    "ต": {"rtgs": "t",   "ipa": "/t/",   "zh_approx": "不送氣，像「特」的 t，嘴巴不噴氣",           "cls": "mid"},
    "ถ": {"rtgs": "th",  "ipa": "/tʰ/",  "zh_approx": "送氣音，像「特」送一口氣，對比 ต",          "cls": "high"},
    "ท": {"rtgs": "th",  "ipa": "/tʰ/",  "zh_approx": "送氣音，同 ถ，像「特」送氣",                "cls": "low"},
    "ธ": {"rtgs": "th",  "ipa": "/tʰ/",  "zh_approx": "送氣音，同 ท",                             "cls": "low"},
    "น": {"rtgs": "n",   "ipa": "/n/",   "zh_approx": "像「那」的 n，非常常見",                    "cls": "low"},
    "บ": {"rtgs": "b",   "ipa": "/b/",   "zh_approx": "不送氣，像「爸」的 b",                      "cls": "mid"},
    "ป": {"rtgs": "p",   "ipa": "/p/",   "zh_approx": "不送氣，像「怕」不送氣版，嘴唇合上不噴氣", "cls": "mid"},
    "ผ": {"rtgs": "ph",  "ipa": "/pʰ/",  "zh_approx": "送氣音，像「坡」的 ph，嘴唇噴氣",           "cls": "high"},
    "ฝ": {"rtgs": "f",   "ipa": "/f/",   "zh_approx": "像「飛」的 f，上齒咬下唇",                  "cls": "high"},
    "พ": {"rtgs": "ph",  "ipa": "/pʰ/",  "zh_approx": "送氣音，同 ผ，像「坡」",                   "cls": "low"},
    "ฟ": {"rtgs": "f",   "ipa": "/f/",   "zh_approx": "像「飛」的 f，同 ฝ 發音",                  "cls": "low"},
    "ภ": {"rtgs": "ph",  "ipa": "/pʰ/",  "zh_approx": "送氣音，同 พ",                             "cls": "low"},
    "ม": {"rtgs": "m",   "ipa": "/m/",   "zh_approx": "像「媽」的 m，雙唇鼻音",                   "cls": "low"},
    "ย": {"rtgs": "y",   "ipa": "/j/",   "zh_approx": "像「也」的 y",                             "cls": "low"},
    "ร": {"rtgs": "r",   "ipa": "/r/",   "zh_approx": "彈舌音，舌尖輕彈，現代口語常接近 l",        "cls": "low"},
    "ล": {"rtgs": "l",   "ipa": "/l/",   "zh_approx": "像「拉」的 l，舌尖抵上顎",                 "cls": "low"},
    "ว": {"rtgs": "w",   "ipa": "/w/",   "zh_approx": "像「哇」的 w，嘴型圓",                     "cls": "low"},
    "ศ": {"rtgs": "s",   "ipa": "/s/",   "zh_approx": "像「斯」的 s，同 ส",                       "cls": "high"},
    "ษ": {"rtgs": "s",   "ipa": "/s/",   "zh_approx": "像「斯」的 s，同 ส，捲舌版",               "cls": "high"},
    "ส": {"rtgs": "s",   "ipa": "/s/",   "zh_approx": "像「斯」的 s，最常見的 s",                 "cls": "high"},
    "ห": {"rtgs": "h",   "ipa": "/h/",   "zh_approx": "像「哈」的 h，氣流輕送",                   "cls": "high"},
    "ฬ": {"rtgs": "l",   "ipa": "/l/",   "zh_approx": "像「拉」的 l，同 ล，較少用",               "cls": "low"},
    "อ": {"rtgs": "",    "ipa": "/ʔ/",   "zh_approx": "聲門塞音，聲母位置時表示「無輔音起頭」",   "cls": "mid"},
    "ฮ": {"rtgs": "h",   "ipa": "/h/",   "zh_approx": "像「哈」的 h，同 ห，低類版",               "cls": "low"},
}

def get_ho_nam_real_consonant(syllable: str) -> str | None:
    """若為 ห นำ 模式，回傳真正的聲母（第二個輔音）。

    ห นำ 條件：ห 和下一個低類輔音必須相鄰（中間無元音）。
    例：หมา(✓) หนู(✓) เหมือน(✓)  但 หุง(✗) ห้าม(✗) หอม(✗)
    """
    _all = HIGH_CLASS | MID_CLASS | LOW_CLASS
    _vowels = set("ะัาิีึืุูเแโใไำ็")
    # Find all consonant positions
    consonants = [(i, c) for i, c in enumerate(syllable) if c in _all]
    # Look for ห followed by a ห นำ partner with NO vowels between them
    for idx, (pos, ch) in enumerate(consonants):
        if ch == "ห" and idx + 1 < len(consonants):
            next_pos, next_ch = consonants[idx + 1]
            # Check adjacency: only tone marks (่้๊๋) allowed between them, no vowels
            between = syllable[pos + 1:next_pos]
            has_vowel = any(c in _vowels for c in between)
            if not has_vowel:
                pair = "ห" + next_ch
                if pair in HO_NAM_PAIRS:
                    return next_ch
    return None

# 短元音字符（無韻尾時 = 聲門塞音收尾 = dead_short）
SHORT_VOWEL_CHARS = set("ะัิึุ")

# ── 常見借詞（閩南語/潮州話/廣東話） ──────────────────────────
LOANWORDS_ZH = {
    "เต้าหู้":    {"origin": "閩南語「豆腐」", "note": "你已經認識這個詞"},
    "กวยเตี๋ยว":  {"origin": "閩南語「粿條」", "note": "你已經認識這個詞"},
    "ก๋วยจั๊บ":   {"origin": "閩南語「粿汁」", "note": "你已經認識這個詞"},
    "บะหมี่":     {"origin": "閩南語「麵」（bā-mī）", "note": "你已經認識這個詞"},
    "เก้าอี้":    {"origin": "廣東話「交椅」", "note": "你已經認識這個詞"},
    "โต๊ะ":       {"origin": "閩南語「桌」（tok）", "note": "你已經認識這個詞"},
    "กุ้ย":       {"origin": "閩南語「鬼」（kúi）", "note": "你已經認識這個詞"},
    "เฮีย":       {"origin": "閩南語「兄」（hia）", "note": "你已經認識這個詞"},
    "อาม่า":      {"origin": "閩南語「阿媽」", "note": "你已經認識這個詞"},
    "อากง":       {"origin": "閩南語「阿公」", "note": "你已經認識這個詞"},
    "เจ๊":        {"origin": "閩南語「姐」（tsé）", "note": "你已經認識這個詞"},
    "ตี๋":        {"origin": "閩南語「弟」（tī）", "note": "你已經認識這個詞"},
    "ซาลาเปา":    {"origin": "閩南語「叉燒包」", "note": "你已經認識這個詞"},
    "เกี๊ยว":     {"origin": "閩南語「餃」（kiáu）", "note": "你已經認識這個詞"},
    "ตะเกียบ":    {"origin": "閩南語「筷」（tī-kap）", "note": "你已經認識這個詞"},
    "ผัดไทย":     {"origin": "泰式，但 ผัด 近閩南語「炒」", "note": "炒的概念你已經認識"},
    "น้ำชา":      {"origin": "น้ำ（水）+ ชา（茶，來自漢語）", "note": "「茶」字你已經認識"},
    "ชาเย็น":     {"origin": "ชา（茶）來自漢語「茶」", "note": "「茶」字你已經認識"},
}

# 視覺易混淆字母對
VISUAL_CONFUSABLES = [
    {"pair": ["ก", "ถ"], "note": "右邊的圈：ก 封口，ถ 開口朝右"},
    {"pair": ["ข", "ช"], "note": "ข 上面有橫線帽，ช 沒有"},
    {"pair": ["ม", "ภ"], "note": "ม 圓滑，ภ 多一個向右的突出"},
    {"pair": ["น", "ท"], "note": "น 簡單，ท 多一條向右的尾巴"},
    {"pair": ["ย", "ซ"], "note": "ย 有向左的頭，ซ 是波浪形"},
    {"pair": ["ว", "อ"], "note": "ว 像英文 U，อ 是封閉的圓"},
    {"pair": ["ร", "ฤ"], "note": "ร 是單獨字母，ฤ 是母音（少見）"},
    {"pair": ["ด", "ต"], "note": "ด 有向上的圈，ต 頭部是橫線"},
]

if __name__ == "__main__":
    import json
    print("聲母數量:", len(INITIAL_TABLE))
    print("韻尾映射數量:", len(FINAL_SOUND))
    print("聲調規則格數:", len(TONE_TABLE))
    print("借詞數量:", len(LOANWORDS_ZH))
    print("\n範例 — ข้าว 的聲母資料:")
    print(json.dumps(INITIAL_TABLE["ข"], ensure_ascii=False, indent=2))
