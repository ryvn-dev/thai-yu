from fastapi.testclient import TestClient

from api.main import app

client = TestClient(app)


def test_tokenize_basic():
    resp = client.post("/tokenize", json={"text": "ฉันชอบกินข้าวผัด"})
    assert resp.status_code == 200
    data = resp.json()
    assert "words" in data
    assert "syllables" in data
    assert len(data["words"]) > 0
    # ฉัน should be one of the words
    assert "ฉัน" in data["words"]


def test_tokenize_empty():
    resp = client.post("/tokenize", json={"text": ""})
    assert resp.status_code == 200
    data = resp.json()
    assert data["words"] == []


def test_tokenize_single_word():
    resp = client.post("/tokenize", json={"text": "สวัสดี"})
    assert resp.status_code == 200
    data = resp.json()
    assert "สวัสดี" in data["words"]
