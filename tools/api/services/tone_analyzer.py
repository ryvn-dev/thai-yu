import sys
from pathlib import Path

_scripts_dir = str(Path(__file__).resolve().parent.parent.parent / "scripts")
if _scripts_dir not in sys.path:
    sys.path.insert(0, _scripts_dir)

from thai_glosses import THAI_ZH_GLOSSES
from word_overrides import WORD_OVERRIDES
from thai_tables import (
    CLUSTER_TABLE,
    CONSONANT_CLUSTERS,
    FINAL_SOUND,
    HO_NAM_PAIRS,
    INITIAL_TABLE,
    SHORT_VOWEL_CHARS,
    TONE_MARKS,
    TONE_TABLE,
    COMPOUND_VOWELS,
    VOWEL_CHARS,
    VOWEL_CHAR_SET,
    HIGH_CLASS,
    MID_CLASS,
    LOW_CLASS,
    O_NAM_PAIRS,
    get_consonant_class,
    get_ho_nam_real_consonant,
    is_cluster,
)

from api.models.schemas import (
    FinalSoundInfo,
    InitialInfo,
    PhonemeBreakdown,
    SyllableAnalysis,
    SyllableParts,
    WordAnalysis,
)
from api.services.tokenizer import (
    romanize_word,
    tokenize_sentences,
    tokenize_syllables,
    tokenize_words,
)

_ALL_CONSONANTS = HIGH_CLASS | MID_CLASS | LOW_CLASS


def _extract_tone_mark(syllable: str) -> str | None:
    for char in syllable:
        if char in TONE_MARKS:
            return TONE_MARKS[char]
    return None


def _extract_initial_consonant(syllable: str) -> str | None:
    """Extract initial consonant or cluster from a syllable."""
    consonants = [(i, c) for i, c in enumerate(syllable) if c in _ALL_CONSONANTS]
    if not consonants:
        return None

    first_char = consonants[0][1]

    # Check for consonant cluster (second consonant is ร, ล, or ว)
    if len(consonants) >= 2:
        second_char = consonants[1][1]
        # Only if they're adjacent (no vowels between them)
        idx1, idx2 = consonants[0][0], consonants[1][0]
        chars_between = syllable[idx1 + 1:idx2]
        no_vowels_between = not any(c in VOWEL_CHAR_SET for c in chars_between)
        if no_vowels_between and is_cluster(first_char, second_char):
            return first_char + second_char

    return first_char


def _extract_final_consonant(syllable: str) -> str | None:
    """Extract final consonant, accounting for clusters."""
    consonants = [c for c in syllable if c in _ALL_CONSONANTS]
    if len(consonants) <= 1:
        return None

    # Check if first two consonants form a cluster
    initial = _extract_initial_consonant(syllable)
    initial_count = len(initial) if initial else 1

    # Remaining consonants after the initial (cluster or single)
    remaining = consonants[initial_count:]
    if not remaining:
        return None

    return remaining[-1]


def _extract_vowels(syllable: str) -> list[dict]:
    """Extract vowel characters from a syllable and return their info."""
    found = []
    for char in syllable:
        if char in VOWEL_CHAR_SET:
            info = VOWEL_CHARS[char]
            found.append({"char": char, **info})
    return found


def _determine_syllable_type(syllable: str, final_consonant: str | None) -> str:
    if final_consonant is None:
        # Open syllable — but short vowel open = dead_short (glottal stop /ʔ/)
        has_short_vowel = any(c in SHORT_VOWEL_CHARS for c in syllable)
        return "dead_short" if has_short_vowel else "live"

    final_info = FINAL_SOUND.get(final_consonant)
    if final_info is None:
        return "live"

    if final_info["type"] == "sonorant":
        return "live"

    # Dead syllable — check vowel length
    vowels = _extract_vowels(syllable)
    has_long = any(v.get("long", False) for v in vowels)

    # สระ อ (ออ) before final consonant is long
    if "อ" in syllable and final_consonant != "อ":
        has_long = True

    return "dead_long" if has_long else "dead_short"


def _check_ho_nam(syllable: str) -> str | None:
    if len(syllable) >= 2 and syllable[:2] in HO_NAM_PAIRS:
        return "high"
    return None


def analyze_syllable(syllable: str) -> SyllableAnalysis:
    initial = _extract_initial_consonant(syllable)
    final = _extract_final_consonant(syllable)
    tone_mark = _extract_tone_mark(syllable)
    syllable_type = _determine_syllable_type(syllable, final)

    # ห นำ detection — use real consonant, not ห
    is_ho_nam = False
    real_initial = get_ho_nam_real_consonant(syllable)
    if real_initial:
        is_ho_nam = True
        initial = real_initial  # ว not ห
        consonant_class = "high"  # promoted by ห นำ
    elif initial:
        # อ นำ detection — อ promotes ย to mid class (อย่า, อยาก, อย่าง, อยู่)
        consonants = [c for c in syllable if c in _ALL_CONSONANTS]
        if (
            len(consonants) >= 2
            and consonants[0] == "อ"
            and consonants[1] == "ย"
            and (consonants[0] + consonants[1]) in O_NAM_PAIRS
        ):
            # Check adjacency (no vowels between อ and ย)
            _vowels_set = set("ะัาิีึืุูเแโใไำ")
            o_pos = syllable.index("อ")
            y_pos = syllable.index("ย", o_pos + 1) if "ย" in syllable[o_pos + 1:] else -1
            between = syllable[o_pos + 1:y_pos] if y_pos > 0 else ""
            if y_pos > 0 and not any(c in _vowels_set for c in between):
                initial = "ย"
                consonant_class = "mid"  # promoted by อ นำ
            else:
                consonant_class = get_consonant_class(initial[0])
        else:
            # For clusters like กว, use first char for class
            consonant_class = get_consonant_class(initial[0])
    else:
        consonant_class = "mid"

    tone_key = (consonant_class, tone_mark, syllable_type)
    tone = TONE_TABLE.get(tone_key, "mid")

    final_sound = None
    if final and final in FINAL_SOUND:
        fs = FINAL_SOUND[final]
        final_sound = FinalSoundInfo(sound=fs["sound"], type=fs["type"], zh=fs["zh"])

    initial_info = None
    # For clusters, look up first char; cluster detail handled in _build_syllable_parts
    init_key = initial[0] if initial else None
    if init_key and init_key in INITIAL_TABLE:
        info = INITIAL_TABLE[init_key]
        initial_info = InitialInfo(
            rtgs=info["rtgs"], ipa=info["ipa"], zh_approx=info["zh_approx"],
        )

    rtgs = romanize_word(syllable)

    return SyllableAnalysis(
        thai=syllable,
        rtgs=rtgs,
        initial_consonant=initial,
        consonant_class=consonant_class,
        tone_mark=tone_mark,
        syllable_type=syllable_type,
        tone=tone,
        final_consonant=final,
        final_sound=final_sound,
        initial_info=initial_info,
    )


def _build_syllable_parts(
    syl: SyllableAnalysis,
    raw_syllable: str,
    *,
    is_ho_nam: bool = False,
    has_implicit_vowel: bool = False,
    original_syllable: str = "",
) -> SyllableParts:
    """Build per-syllable phoneme breakdown: 聲母 + 韻母 + 韻尾.

    All chars and sounds come from pronunciate (actual pronunciation).
    The original spelling is shown in the syllable header, not here.
    """
    parts: list[PhonemeBreakdown] = []

    # 聲母 — check for cluster first, then single consonant
    if syl.initial_consonant:
        init = syl.initial_consonant
        cluster_info = CLUSTER_TABLE.get(init) if len(init) >= 2 else None

        if cluster_info:
            zh = cluster_info["zh"]
            if is_ho_nam:
                zh += "（ห 引導 → 高類）"
            parts.append(PhonemeBreakdown(
                label="聲母",
                char=init,
                sound=cluster_info["ipa"],
                zh_approx=zh,
            ))
        elif syl.initial_info:
            zh = syl.initial_info.zh_approx
            if is_ho_nam:
                zh += "（ห 引導 → 高類）"
            parts.append(PhonemeBreakdown(
                label="聲母",
                char=init,
                sound=syl.initial_info.ipa,
                zh_approx=zh,
            ))

    # 韻母 — check ็ first, then compound vowels, special patterns, then single vowels
    vowels = _extract_vowels(raw_syllable)
    vowel_added = False

    # ็ (mai taikhu) = short vowel marker
    # เ-็ = short /e/, แ-็ = short /ɛ/, ็ alone = short /ɔ/
    if not vowel_added and "็" in raw_syllable:
        has_e = "เ" in raw_syllable
        has_ae = "แ" in raw_syllable
        if has_e:
            parts.append(PhonemeBreakdown(
                label="韻母", char="เ-็",
                sound="/e/", zh_approx="短元音，像短「誒」",
            ))
        elif has_ae:
            parts.append(PhonemeBreakdown(
                label="韻母", char="แ-็",
                sound="/ɛ/", zh_approx="短元音，像短「欸」",
            ))
        else:
            parts.append(PhonemeBreakdown(
                label="韻母", char="็",
                sound="/ɔ/", zh_approx="短元音標記，像短「哦」",
            ))
        vowel_added = True

    if vowels:
        vowel_char_set = frozenset(v["char"] for v in vowels)

        # Special: เ-อะ pattern (เลอะ) — เ+ะ in vowels, อ as consonant
        # Must check BEFORE compound lookup since เ+ะ also matches เ-ะ
        if vowel_char_set == frozenset({"เ", "ะ"}):
            consonants = [c for c in raw_syllable if c in _ALL_CONSONANTS]
            if "อ" in consonants and consonants[-1] == "อ":
                parts.append(PhonemeBreakdown(
                    label="韻母", char="เ-อะ",
                    sound="/ɤ/", zh_approx="短元音，像「餓」嘴微張",
                ))
                vowel_added = True

        compound = COMPOUND_VOWELS.get(vowel_char_set) if not vowel_added else None

        # Special: เ-อ pattern (เธอ, เจอ) — อ is consonant not in vowel set
        # Detect: has เ + อ appears after consonant (not as initial)
        if not compound and "เ" in vowel_char_set and len(vowel_char_set) == 1:
            consonants = [c for c in raw_syllable if c in _ALL_CONSONANTS]
            if len(consonants) >= 2 and consonants[-1] == "อ":
                parts.append(PhonemeBreakdown(
                    label="韻母", char="เ-อ",
                    sound="/ɤː/", zh_approx="像「餓」拉長，嘴微張",
                ))
                vowel_added = True

        # Special: ัว pattern (กลัว, วัว, ตัว) — ว acts as part of vowel
        if not vowel_added and not compound and "ั" in vowel_char_set:
            consonants = [c for c in raw_syllable if c in _ALL_CONSONANTS]
            if consonants and consonants[-1] == "ว":
                parts.append(PhonemeBreakdown(
                    label="韻母", char="-ัว",
                    sound="/ua/", zh_approx="像「烏啊」，u 滑向 a",
                ))
                vowel_added = True

        if not vowel_added and compound:
            parts.append(PhonemeBreakdown(
                label="韻母", char=compound["display"],
                sound=compound["ipa"], zh_approx=compound["zh"],
            ))
            vowel_added = True

        if not vowel_added:
            vowel_chars = "".join(v["char"] for v in vowels)
            primary = vowels[0]
            parts.append(PhonemeBreakdown(
                label="韻母", char=vowel_chars,
                sound=primary["ipa"], zh_approx=primary["zh"],
            ))
            vowel_added = True

    # Special: -วย pattern (ช่วย, รวย, หวย, สวย) — วย = /uai/ diphthong
    # No explicit vowel chars, ว and ย are both consonants acting as vowel
    if not vowel_added:
        consonants = [c for c in raw_syllable if c in _ALL_CONSONANTS]
        if len(consonants) >= 3 and consonants[-2] == "ว" and consonants[-1] == "ย":
            parts.append(PhonemeBreakdown(
                label="韻母", char="-วย",
                sound="/uai/", zh_approx="像「歪」，u-a-i 三滑音",
            ))
            vowel_added = True

    # Special: อ acting as vowel /ɔː/ — no vowel chars detected
    # Pattern 1: C + อ (final position: กอ, ขอ, พ่อ)
    # Pattern 2: C + อ + coda (middle position: คลอง, ป้อม, สอง, มอบ)
    if not vowel_added:
        consonants = [(i, c) for i, c in enumerate(raw_syllable) if c in _ALL_CONSONANTS]
        o_positions = [i for i, (_, c) in enumerate(consonants) if c == "อ"]
        if o_positions:
            # อ is present as a consonant — it's acting as vowel
            o_idx = o_positions[0]
            initial = syl.initial_consonant or ""
            initial_count = len(initial)
            # อ should be after the initial consonant(s), not be the initial itself
            if o_idx >= initial_count or (initial_count == 0 and o_idx > 0):
                parts.append(PhonemeBreakdown(
                    label="韻母", char="-อ",
                    sound="/ɔː/", zh_approx="長元音，嘴圓像「哦——」",
                ))
                vowel_added = True

    # Implicit short vowel: no vowel detected at all (จม, ทบ, กล, ตร, etc.)
    # These have an implied short /o/ or /a/
    if not vowel_added:
        parts.append(PhonemeBreakdown(
            label="韻母", char="(隱含)",
            sound="/o/", zh_approx="隱含短元音，像短「哦」",
        ))
        vowel_added = True

    # 韻尾 — from pronunciate
    if syl.final_sound and syl.final_consonant:
        parts.append(PhonemeBreakdown(
            label="韻尾",
            char=syl.final_consonant,
            sound=syl.final_sound.sound,
            zh_approx=syl.final_sound.zh,
            is_silent=syl.final_sound.type == "stop",
        ))

    # Build tone reason for this syllable
    cls_label = {"high": "高類", "mid": "中類", "low": "低類"}.get(
        syl.consonant_class or "", syl.consonant_class or "")
    mark_label = {"mai_ek": " + ่", "mai_tho": " + ้",
                  "mai_tri": " + ๊", "mai_chattawa": " + ๋"}.get(
        syl.tone_mark or "", "")
    syl_label = {"live": "活音節", "dead_long": "長元音閉音節",
                 "dead_short": "短元音閉音節"}.get(
        syl.syllable_type, syl.syllable_type)
    ho_nam_note = "（ห นำ → 高類）" if is_ho_nam else ""
    tone_reason = f"{cls_label}聲母{ho_nam_note}{mark_label} + {syl_label} → {syl.tone}"

    return SyllableParts(
        thai=syl.thai,
        original_thai=original_syllable or syl.thai,
        rtgs=syl.rtgs,
        tone=syl.tone,
        tone_reason=tone_reason,
        parts=parts,
        is_ho_nam=is_ho_nam,
        has_implicit_vowel=has_implicit_vowel,
    )


def _map_original_to_pronunciation(original: str, pron_syllables: list[str]) -> list[str]:
    """Map original word characters to pronunciation syllable boundaries.

    Ensures original_syllables has same length as pron_syllables,
    and join(original_syllables) == original.
    """
    orig_chars = list(original)
    result = []
    orig_idx = 0
    added_chars = set("ะ")  # chars pronunciate adds (implicit short-a)

    for i, pron_syl in enumerate(pron_syllables):
        matched: list[str] = []
        pron_idx = 0

        while orig_idx < len(orig_chars) and pron_idx < len(pron_syl):
            orig_c = orig_chars[orig_idx]
            pron_c = pron_syl[pron_idx]

            if orig_c == pron_c:
                matched.append(orig_c)
                orig_idx += 1
                pron_idx += 1
            elif pron_c == "ห" and pron_idx == 0:
                pron_idx += 1  # skip added ห นำ
            elif pron_c in added_chars:
                pron_idx += 1  # skip added implicit vowel
            else:
                matched.append(orig_c)
                orig_idx += 1
                pron_idx += 1

        if i == len(pron_syllables) - 1:
            matched.extend(orig_chars[orig_idx:])
            orig_idx = len(orig_chars)

        result.append("".join(matched))

    return result


def _build_from_override(word: str, override: dict) -> WordAnalysis:
    """Build WordAnalysis from a WORD_OVERRIDES entry."""
    rtgs = override["rtgs"]
    syllable_parts = []
    tones = []
    original_syls = [word]  # single-syllable override words

    for syl_def in override["syllables"]:
        tone = syl_def["tone"]
        tones.append(tone)

        parts: list[PhonemeBreakdown] = []
        if syl_def.get("onset"):
            parts.append(PhonemeBreakdown(
                label="聲母", char=syl_def["onset"],
                sound=syl_def.get("onset_ipa", ""),
                zh_approx=syl_def.get("zh_onset", ""),
            ))
        if syl_def.get("vowel"):
            parts.append(PhonemeBreakdown(
                label="韻母", char=syl_def["vowel"],
                sound=syl_def.get("vowel_ipa", ""),
                zh_approx=syl_def.get("zh_vowel", ""),
            ))
        if syl_def.get("coda"):
            fs = FINAL_SOUND.get(syl_def["coda"])
            parts.append(PhonemeBreakdown(
                label="韻尾", char=syl_def["coda"],
                sound=fs["sound"] if fs else "",
                zh_approx=fs["zh"] if fs else "",
                is_silent=fs["type"] == "stop" if fs else False,
            ))

        syllable_parts.append(SyllableParts(
            thai=word, original_thai=word, rtgs=rtgs,
            tone=tone, tone_reason="",
            parts=parts,
            is_ho_nam=syl_def.get("ho_nam", False),
            has_implicit_vowel=False,
        ))

    return WordAnalysis(
        thai=word, rtgs=rtgs,
        gloss=THAI_ZH_GLOSSES.get(word, "…"),
        syllables=[], tones=tones,
        original_syllables=original_syls,
        syllable_parts=syllable_parts,
    )


def analyze_word(word: str) -> WordAnalysis:
    # Check override table first
    if word in WORD_OVERRIDES:
        return _build_from_override(word, WORD_OVERRIDES[word])

    raw_syllables = tokenize_syllables(word)
    analyzed = [analyze_syllable(s) for s in raw_syllables]

    # Map original spelling chars to pronunciation syllable boundaries
    original_syls = _map_original_to_pronunciation(word, raw_syllables)

    word_rtgs = romanize_word(word)
    tones = [syl.tone for syl in analyzed] if analyzed else ["mid"]

    syllable_parts = []
    for syl, raw, orig in zip(analyzed, raw_syllables, original_syls):
        # Check ห นำ: pronunciate form has หC pair
        pron_ho_nam = get_ho_nam_real_consonant(raw) is not None
        orig_ho_nam = get_ho_nam_real_consonant(orig) is not None
        # Accept if: original has ห นำ, OR pronunciate added ห (not in original)
        # Reject if: pronunciate rearranged existing chars to create false ห นำ
        #   (e.g. หาว→หวาว: orig has ห but NOT adjacent to ว)
        pron_added_h = "ห" in raw and "ห" not in orig
        is_ho_nam = pron_ho_nam and (orig_ho_nam or pron_added_h)
        # Implicit vowel = pronunciate added a vowel char not in original
        # (e.g. สะ has ะ that ส doesn't)
        has_implicit = any(c in VOWEL_CHAR_SET and c not in orig for c in raw)
        syllable_parts.append(_build_syllable_parts(
            syl, raw,
            is_ho_nam=is_ho_nam,
            has_implicit_vowel=has_implicit,
            original_syllable=orig,
        ))

    return WordAnalysis(
        thai=word,
        rtgs=word_rtgs,
        gloss=THAI_ZH_GLOSSES.get(word, "…"),
        syllables=analyzed,
        tones=tones,
        original_syllables=original_syls,
        syllable_parts=syllable_parts,
    )


def analyze_text(text: str) -> list[list[WordAnalysis]]:
    """Analyze text, returning sentences of words.

    Returns a list of sentences, each sentence is a list of WordAnalysis.
    """
    sentences = tokenize_sentences(text)
    result: list[list[WordAnalysis]] = []

    for sentence in sentences:
        words = tokenize_words(sentence)
        analyzed_words = [analyze_word(w) for w in words]
        if analyzed_words:
            result.append(analyzed_words)

    # Fallback: if no sentences found, treat entire text as one sentence
    if not result:
        words = tokenize_words(text)
        if words:
            result.append([analyze_word(w) for w in words])

    return result
