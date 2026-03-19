from fastapi import FastAPI

from api.routers import analyze, health, tokenize

app = FastAPI(
    title="泰嶼 API",
    description="Thai reading analysis — word segmentation, tone rules, phonetic breakdown",
    version="0.1.0",
)

app.include_router(health.router, tags=["health"])
app.include_router(tokenize.router, tags=["tokenize"])
app.include_router(analyze.router, tags=["analyze"])
