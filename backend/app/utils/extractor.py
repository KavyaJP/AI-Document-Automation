import io

from pypdf import PdfReader
from PIL import Image
import pytesseract

pytesseract.pytesseract.tesseract_cmd = r"E:\tesseract-ocr\tesseract.exe"


async def extract_information(file_content: bytes, file_name: str):
    if file_name.lower().endswith(".pdf"):
        pdf_stream = io.BytesIO(file_content)
        reader = PdfReader(pdf_stream)
        extracted_text = " ".join([page.extract_text() for page in reader.pages])
        return extracted_text

    elif file_name.lower().endswith((".png", ".jpeg", ".jpg")):
        image_stream = io.BytesIO(file_content)
        image = Image.open(image_stream)
        return pytesseract.image_to_string(image)

    else:
        raise ValueError("Unsupported File format")
