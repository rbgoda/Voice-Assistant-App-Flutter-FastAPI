from lang_utils import detect_language

def generate_response(text):
    lang = detect_language(text)
    
    if lang == "zh":
        return "你好，我明白了。"  # Placeholder for Qwen call
    elif lang == "en":
        return "Got it! How can I help?"  # Placeholder for OpenAI call
    else:
        return "Entendido. ¿En qué puedo ayudarte?"  # Placeholder for Gemini call
