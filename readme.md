# DocQuery

## Overview

DocQuery is an AI-powered document platform to extract, analyze, and retrieve information from documents efficiently.

## Technology Stack

### Backend 

- Python FastAPI
- Uvicorn (Application Server)
- Tesseract OCR
- LangChain and Ollama for LLM inference
- RecursiveCharacterTextSplitter for document chunking
- Hugging Face Embedding Model: `all-MiniLM-L6-v2`
- ChromaDB for vector storage

### Frontend

- Flutter

---

## Development Environment Setup

### 1. Create and Activate a Virtual Environment

Create a virtual environment:

```bash
python -m venv .venv
```

#### Windows

```bash
.venv\Scripts\activate.bat
```

#### Linux and macOS

```bash
source .venv/bin/activate
```

### 2. Install Backend Dependencies

Install the required Python packages:

```bash
pip install -r requirements.txt
```

### 3. Install Tesseract OCR

DocQuery uses Tesseract OCR to extract text from images and scanned documents.

#### Option A: Automatic Detection (Recommended)

If Tesseract is installed and available in your system PATH, the application will detect it automatically.

**Installation Instructions**

**macOS**

```bash
brew install tesseract
```

**Linux**

```bash
sudo apt update -y
sudo apt install tesseract-ocr
```

**Windows**

Install Tesseract using the official installer:

https://github.com/UB-Mannheim/tesseract/wiki

After installation, ensure that the Tesseract installation directory is added to your system PATH.

#### Option B: Manual Configuration

If you prefer to use a specific Tesseract installation, create a `.env` file inside the `backend/` directory and specify the executable path:

```env
tesseract_path="C:\Path\To\Your\tesseract.exe"
```

#### Verify Installation

Confirm that Tesseract is installed correctly by running:

```bash
tesseract --version
```

---

## API Documentation

For API usage examples and integration details, refer to [Documentation](backend/api_examples.md)

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
