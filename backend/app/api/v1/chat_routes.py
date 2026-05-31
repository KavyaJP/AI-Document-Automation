from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from langchain_ollama import OllamaLLM

from app.config import PROMPT
from app.utils.vector_store import get_relevant_chunks

router = APIRouter()


class ChatRequest(BaseModel):
    query: str
    model_name: str


@router.post("/ask")
async def ask_document(request: ChatRequest):
    try:
        print("\n\nEntered the ask document function\n\n")
        context_chunks = get_relevant_chunks(query=request.query)

        context_text = "\n\n---\n\n".join(context_chunks)

        formatted_prompt = PROMPT.format(context=context_text, question=request.query)

        llm = OllamaLLM(model=request.model_name)
        response = llm.invoke(formatted_prompt)
        
        print("\n\nReturning the answer\n\n")

        return {
            "question": request.query,
            "answer": response,
            "context_used": context_text,
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
