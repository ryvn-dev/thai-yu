from fastapi.testclient import TestClient

from api.main import app

client = TestClient(app)


def _words(text: str):
    resp = client.post("/analyze", json={"text": text})
    assert resp.status_code == 200
    words = []
    for sent in resp.json()["sentences"]:
        words.extend(sent["words"])
    return words


def test_analyze_basic():
    words = _words("กิน")
    assert len(words) > 0
    assert words[0]["thai"] == "กิน"
    assert words[0]["tones"] == ["mid"]


def test_analyze_multiple_words():
    words = _words("ฉันชอบกิน")
    assert len(words) >= 2


def test_analyze_tone_fall():
    words = _words("ข้าว")
    assert words[0]["tones"] == ["fall"]


def test_analyze_multi_syllable_tones():
    """สวัสดี = 3 syllables with different tones"""
    words = _words("สวัสดี")
    assert len(words[0]["tones"]) == 3


def test_analyze_sawatdi_pronunciation():
    """สวัสดี should be 3 syllables via pronunciate()"""
    words = _words("สวัสดี")
    assert words[0]["rtgs"] == "sawatdi"
    assert len(words[0]["syllable_parts"]) == 3


def test_analyze_empty():
    resp = client.post("/analyze", json={"text": ""})
    assert resp.status_code == 200
    assert resp.json()["sentences"] == []


def test_analyze_sentence_splitting():
    """Multiple lines should produce multiple sentences"""
    resp = client.post("/analyze", json={"text": "สวัสดีครับ\nขอบคุณครับ"})
    assert resp.status_code == 200
    sents = resp.json()["sentences"]
    assert len(sents) >= 2
