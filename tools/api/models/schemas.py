from pydantic import BaseModel, Field


class TextRequest(BaseModel):
    text: str = Field(..., min_length=1, max_length=10000)


class TokenizeResponse(BaseModel):
    words: list[str]
    syllables: list[str]


class FinalSoundInfo(BaseModel):
    sound: str
    type: str  # "stop" | "sonorant"
    zh: str


class InitialInfo(BaseModel):
    rtgs: str
    ipa: str
    zh_approx: str


class PhonemeBreakdown(BaseModel):
    label: str       # 聲母 / 韻母 / 韻尾
    char: str
    sound: str       # IPA
    zh_approx: str   # 中文近似音
    is_silent: bool = False


class SyllableParts(BaseModel):
    thai: str              # pronunciate form (e.g. หวัด)
    original_thai: str = ""  # original spelling (e.g. วัส)
    rtgs: str
    tone: str
    tone_reason: str = ""  # why this tone (per-syllable)
    gloss: str = "…"       # per-syllable Chinese meaning
    parts: list[PhonemeBreakdown]
    is_ho_nam: bool = False
    has_implicit_vowel: bool = False


class SyllableAnalysis(BaseModel):
    thai: str
    rtgs: str = ""
    initial_consonant: str | None = None
    consonant_class: str | None = None
    tone_mark: str | None = None
    syllable_type: str = "live"
    tone: str = "mid"
    final_consonant: str | None = None
    final_sound: FinalSoundInfo | None = None
    initial_info: InitialInfo | None = None


class WordAnalysis(BaseModel):
    thai: str
    rtgs: str = ""
    gloss: str = "…"
    syllables: list[SyllableAnalysis]
    tones: list[str]  # one tone per syllable, e.g. ["low", "mid"]
    original_syllables: list[str] = []  # original spelling split (for display coloring)
    syllable_parts: list[SyllableParts] = []


class SentenceAnalysis(BaseModel):
    words: list[WordAnalysis]
    sentence_gloss: str = ""  # combined Chinese meaning for the sentence


class AnalyzeResponse(BaseModel):
    sentences: list[SentenceAnalysis]
