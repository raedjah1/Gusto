import whisper
import sys

def transcribe_audio(audio_path):
    # Load the Whisper model (you can change "base" to other sizes like "tiny", "small", etc.)
    model = whisper.load_model("base")
    
    # Transcribe the audio file
    result = model.transcribe(audio_path)
    
    # Print the transcription text, which will be captured by Ruby
    print(result["text"])

if __name__ == "__main__":
    audio_file = sys.argv[1]  # Get the audio file path from the command line
    transcribe_audio(audio_file)
