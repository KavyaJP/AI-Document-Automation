# Automatic Smart Document

## TechStack

- Backend:
  - Python FastAPI
  - Tesseract for OCR
  - Ollama for LLM inference support

## Development Environment Setup Process

1.  Create & activate virtual environment:

```bash
python -m venv venv
```

- **Windows:**

  ```bash
  .venv\Scripts\activate.bat
  ```

- **Linux & MacOS:**

  ```bash
  source .venv/bin/activate
  ```

2.  Download the libraries required for backend:

```bash
pip3 install -r requirements.txt
```

3.  Download Tesseract OCR engine

This project uses the open source tool [Tesseract OCR](https://github.com/tesseract-ocr/tesseract) to extract text from images.

**Option A: Automatic Detection (Recommended)**
If Tesseract is installed and added to your system's PATH, the application will detect it automatically.

**How to install it:**

- **macOS:** `brew install tesseract`
- **Linux:** `sudo apt update -y && sudo apt-get install tesseract-ocr`
- **Windows:** Install via [this installer](https://github.com/UB-Mannheim/tesseract/wiki), then add the installation folder to your System PATH.

**Option B: Manual Override**
If you have a specific version you want to use, or if you don't want to modify your system PATH, create a `.env` file in the `backend/` folder and add the following:
`tesseract_path="C:\Path\To\Your\tesseract.exe"`

_Tip: Verify your installation by running `tesseract --version` in your terminal._

## LICENSE

This project is licensed under [MIT LICENSE](LICENSE)
