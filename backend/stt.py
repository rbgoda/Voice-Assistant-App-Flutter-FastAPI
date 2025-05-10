from google.cloud import speech_v1p1beta1 as speech

def transcribe_audio(audio_file):
    client = speech.SpeechClient()
    content = audio_file.read()

    audio = speech.RecognitionAudio(content=content)
    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
        sample_rate_hertz=16000,
        language_code="en-US",
        alternative_language_codes=["es", "fr", "zh-CN"]
    )

    response = client.recognize(config=config, audio=audio)
    for result in response.results:
        return result.alternatives[0].transcript
    return ""
