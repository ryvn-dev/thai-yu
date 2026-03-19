from api.services.tone_analyzer import analyze_syllable, analyze_word


def test_mid_tone_kin():
    """กิน: ก mid class, no mark, live → mid"""
    result = analyze_syllable("กิน")
    assert result.initial_consonant == "ก"
    assert result.consonant_class == "mid"
    assert result.tone_mark is None
    assert result.tone == "mid"


def test_fall_tone_khao():
    """ข้าว: ข high class, mai_tho, live → fall"""
    result = analyze_syllable("ข้าว")
    assert result.initial_consonant == "ข"
    assert result.consonant_class == "high"
    assert result.tone_mark == "mai_tho"
    assert result.tone == "fall"


def test_rise_tone_chan():
    """ฉัน: ฉ high class, no mark, live → rise"""
    result = analyze_syllable("ฉัน")
    assert result.initial_consonant == "ฉ"
    assert result.consonant_class == "high"
    assert result.tone == "rise"


def test_low_tone_phat():
    """ผัด: ผ high class, no mark, dead short → low"""
    result = analyze_syllable("ผัด")
    assert result.initial_consonant == "ผ"
    assert result.consonant_class == "high"
    assert result.tone == "low"


def test_final_sound_stop():
    """ผัด ends with ด → /-t/ stop"""
    result = analyze_syllable("ผัด")
    assert result.final_consonant == "ด"
    assert result.final_sound is not None
    assert result.final_sound.type == "stop"


def test_final_sound_sonorant():
    """กิน ends with น → /-n/ sonorant"""
    result = analyze_syllable("กิน")
    assert result.final_consonant == "น"
    assert result.final_sound is not None
    assert result.final_sound.type == "sonorant"


def test_analyze_word_multisyllable():
    """สวัสดี = สวัส + ดี"""
    result = analyze_word("สวัสดี")
    assert result.thai == "สวัสดี"
    assert len(result.syllables) >= 1
