from fastapi import APIRouter
import httpx

router = APIRouter()


@router.get("/local_models")
async def local_models():
    async with httpx.AsyncClient() as client:
        response = await client.get("http://localhost:11434/api/tags")
        response.raise_for_status()
        return response.json()


@router.get("/recommended_models")
def recommended_models():
    return {
        "no_vram": "qwen2.5:3b",
        "4gb_vram": "gemma3:4b",
        "6gb_vram": "qwen2.5:7b",
        "8gb_vram": "qwen2.5:7b",
        "12gb_vram": "gemma3:12b",
        "16gb_vram": "deepseek-r1:14b",
        "24gb_vram": "qwen2.5:32b",
        "48gb_plus_vram": "llama3.3:70b",
    }
