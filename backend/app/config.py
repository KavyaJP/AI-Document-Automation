import os
import shutil
from pathlib import Path
from dotenv import load_dotenv
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_core.prompts import PromptTemplate

current_file = Path(__file__).resolve()
BACKEND_PATH = current_file.parent.parent
env_path = BACKEND_PATH / ".env"

load_dotenv(dotenv_path=env_path)

TESSERACT_PATH = os.getenv("tesseract_path")

if not TESSERACT_PATH:
    TESSERACT_PATH = shutil.which("tesseract")

DB_PATH = current_file.parent.parent.parent / "chroma_db"

EMBEDDING_MODEL = HuggingFaceEmbeddings(model_name="all-MiniLM-L6-v2")

RAG_TEMPLATE = """
You are a helpful AI assistant. Use the following pieces of retrieved context to answer the user's question. 
If you don't know the answer based on the context, just say that you don't know. Do not hallucinate.

Context:
{context}

Question:
{question}

Answer:
"""

PROMPT = PromptTemplate.from_template(RAG_TEMPLATE)
