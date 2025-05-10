from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

from stt import transcribe_audio
from tts import text_to_speech
from llm_router import generate_response

app = FastAPI()

# Allow CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/stt")
async def stt(file: UploadFile = File(...)):
    text = transcribe_audio(file.file)
    return {"text": text}

@app.post("/ask")
async def ask(data: dict):
    response = generate_response(data["text"])
    return {"response": response}

@app.post("/tts")
async def tts(data: dict):
    audio_path = text_to_speech(data["text"], data.get("lang", "en-US"))
    return {"audio_url": f"/audio/{audio_path}"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
