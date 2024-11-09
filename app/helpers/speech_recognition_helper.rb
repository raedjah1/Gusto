module SpeechRecognitionHelper
    def transcribe_audio(audio_path)
      # Call the Python script and capture its output
      transcription = `python3 transcribe_audio.py #{audio_path}`
      transcription.strip # Remove any leading/trailing whitespace
    end
  end
  