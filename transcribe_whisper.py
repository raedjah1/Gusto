
import sys
import warnings
import whisper


# Suppress FutureWarning and UserWarning to avoid cluttering the output
warnings.filterwarnings("ignore", category=FutureWarning)
warnings.filterwarnings("ignore", category=UserWarning)

def transcribe_audio(audio_path):
    print("Loading Whisper model...")
    model = whisper.load_model("base") # type: ignore
    print("Model loaded successfully.")
    
    # Transcribe the audio file
    print("Transcribing audio...")
    result = model.transcribe(audio_path)
    print("Transcription completed.")
    
    # Print the transcription text
    print("Transcription result:")
    print(result["text"])

if __name__ == "__main__":
    # Get the audio file path from the command line
    if len(sys.argv) > 1:
        audio_file = sys.argv[1]
        print(f"Audio file provided: {audio_file}")
        transcribe_audio(audio_file)
    else:
        print("Please provide the path to the audio file.")
