from fastapi import APIRouter

from api.models.schemas import AnalyzeResponse, SentenceAnalysis, TextRequest
from api.services.tone_analyzer import analyze_text

router = APIRouter()


@router.post("/analyze", response_model=AnalyzeResponse)
def analyze(req: TextRequest):
    sentence_words = analyze_text(req.text)
    sentences = []
    for words in sentence_words:
        glosses = [w.gloss for w in words if w.gloss and w.gloss != "…"]
        sentence_gloss = "".join(glosses) if glosses else ""
        sentences.append(
            SentenceAnalysis(words=words, sentence_gloss=sentence_gloss)
        )
    return AnalyzeResponse(sentences=sentences)
