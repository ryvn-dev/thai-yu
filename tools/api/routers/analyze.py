from fastapi import APIRouter

from api.models.schemas import AnalyzeResponse, SentenceAnalysis, TextRequest
from api.services.tone_analyzer import analyze_text

router = APIRouter()


@router.post("/analyze", response_model=AnalyzeResponse)
def analyze(req: TextRequest):
    sentence_words = analyze_text(req.text)
    sentences = [SentenceAnalysis(words=words) for words in sentence_words]
    return AnalyzeResponse(sentences=sentences)
