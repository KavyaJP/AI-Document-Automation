import io
import os

from pypdf import PdfReader
from PIL import Image
import pytesseract

from app.config import TESSERACT_PATH

pytesseract.pytesseract.tesseract_cmd = TESSERACT_PATH


async def extract_text(file_content: bytes, file_name: str):
    ext = os.path.splitext(file_name)[1].lower()

    if ext == ".pdf":
        pdf_stream = io.BytesIO(file_content)
        reader = PdfReader(pdf_stream)
        extracted_text = " ".join([page.extract_text() for page in reader.pages])
        return extracted_text

    elif ext in [".png", ".jpg", ".jpeg", ".tiff", ".tif", ".bmp", ".gif", ".webp"]:
        image_stream = io.BytesIO(file_content)
        image = Image.open(image_stream)
        return pytesseract.image_to_string(image)

    elif ext in [".txt", ".md"]:
        try:
            return file_content.decode("utf-8")
        except UnicodeDecodeError:
            return file_content.decode("utf-8", errors="ignore")

    else:
        raise ValueError("Unsupported File format")
