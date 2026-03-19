from fastapi import APIRouter

from api.models.schemas import TextRequest, TokenizeResponse
from api.services.tokenizer import tokenize_syllables, tokenize_words

router = APIRouter()


@router.post("/tokenize", response_model=TokenizeResponse)
def tokenize(req: TextRequest):
    words = tokenize_words(req.text)
    syllables = tokenize_syllables(req.text)
    return TokenizeResponse(words=words, syllables=syllables)
