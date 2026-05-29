from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.v1 import ollama_routes

app = FastAPI(title="Smart Document Workflow API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(ollama_routes.router, prefix="/api/v1/models")


@app.get("/")
def root():
    return {"status": "ok", "message": "API is working"}
