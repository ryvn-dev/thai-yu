"""Complex word analysis tests — implicit vowels, ห นำ, multi-tone, loanwords."""
from fastapi.testclient import TestClient

from api.main import app

client = TestClient(app)


def _analyze(text: str):
    resp = client.post("/analyze", json={"text": text})
    assert resp.status_code == 200
    data = resp.json()
    # Flatten all sentences' words
    words = []
    for sent in data["sentences"]:
        words.extend(sent["words"])
    return words


class TestImplicitVowels:
    """Words where pronunciate splits differently from naive syllable_tokenize."""

    def test_sawatdi(self):
        """สวัสดี → 3 syllables with implicit vowel flag"""
        words = _analyze("สวัสดี")
        w = words[0]
        assert w["rtgs"] == "sawatdi"
        assert len(w["tones"]) == 3
        # At least one syllable should have implicit vowel
        assert any(sp["has_implicit_vowel"] for sp in w["syllable_parts"])

    def test_sabai(self):
        """สบาย → สะ-บาย (implicit a in ส)"""
        words = _analyze("สบาย")
        w = words[0]
        assert len(w["tones"]) == 2
        assert "sa" in w["rtgs"]

    def test_sanuk(self):
        """สนุก → สะ-นุก (implicit a)"""
        words = _analyze("สนุก")
        w = words[0]
        assert len(w["tones"]) >= 2

    def test_aroy(self):
        """อร่อย → อะ-ร่อย (implicit a)"""
        words = _analyze("อร่อย")
        w = words[0]
        assert len(w["tones"]) >= 2


class TestHoNam:
    """ห นำ — ห as tone-class promoter for low-class consonants."""

    def test_ho_nam_in_sawatdi(self):
        """สวัสดี has หวัด syllable with ห นำ"""
        words = _analyze("สวัสดี")
        syl_parts = words[0]["syllable_parts"]
        # Find the หวัด syllable
        ho_nam_syls = [sp for sp in syl_parts if sp["is_ho_nam"]]
        assert len(ho_nam_syls) >= 1
        # Its initial should be ว not ห
        ho_syl = ho_nam_syls[0]
        onset_parts = [p for p in ho_syl["parts"] if p["label"] == "聲母"]
        assert onset_parts[0]["char"] == "ว"
        assert "ห 引導" in onset_parts[0]["zh_approx"]

    def test_hma(self):
        """หมา (dog) — ห นำ + ม"""
        words = _analyze("หมา")
        w = words[0]
        syl_parts = w["syllable_parts"]
        if syl_parts:
            onset = [p for p in syl_parts[0]["parts"] if p["label"] == "聲母"]
            if onset:
                # Should show ม as initial, not ห
                assert onset[0]["char"] == "ม"


class TestMultiTone:
    """Words with different tones per syllable."""

    def test_sawatdi_three_tones(self):
        """สวัสดี has 3 different syllables, each with own tone"""
        words = _analyze("สวัสดี")
        tones = words[0]["tones"]
        assert len(tones) == 3

    def test_khopkhun(self):
        """ขอบคุณ = ขอบ + คุณ"""
        words = _analyze("ขอบคุณ")
        w = words[0]
        assert len(w["tones"]) >= 2

    def test_prathet_thai(self):
        """ประเทศไทย — may be 1 or 2 words depending on tokenizer"""
        words = _analyze("ประเทศไทย")
        all_tones = []
        for w in words:
            all_tones.extend(w["tones"])
        assert len(all_tones) >= 2  # at least 2 syllables total


class TestOriginalSyllables:
    """original_syllables should be original spelling, not pronunciate form."""

    def test_sawatdi_original_vs_pronunciation(self):
        """สวัสดี: original_syllables maps to same count as tones"""
        words = _analyze("สวัสดี")
        w = words[0]
        orig = w["original_syllables"]
        pron = [sp["thai"] for sp in w["syllable_parts"]]
        # Both should have 3 parts (mapped to pronunciation boundaries)
        assert len(orig) == 3  # ส + วัส + ดี
        assert len(pron) == 3  # สะ + หวัด + ดี
        assert len(orig) == len(w["tones"])
        # Original should reconstruct the word
        assert "".join(orig) == "สวัสดี"

    def test_simple_word_same(self):
        """กิน: original and pronunciation should be the same"""
        words = _analyze("กิน")
        w = words[0]
        assert len(w["original_syllables"]) == 1
        assert w["original_syllables"][0] == "กิน"


class TestSingleSyllable:
    """Single-syllable words should still work correctly."""

    def test_kin(self):
        words = _analyze("กิน")
        w = words[0]
        assert w["tones"] == ["mid"]
        assert w["rtgs"] == "kin"

    def test_khao(self):
        words = _analyze("ข้าว")
        w = words[0]
        assert w["tones"] == ["fall"]

    def test_chan(self):
        words = _analyze("ฉัน")
        w = words[0]
        assert w["tones"] == ["rise"]
