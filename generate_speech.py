from TTS.api import TTS
import torch
import sys
import os
import logging

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class GustoTTS:
    def __init__(self, model_name="tts_models/en/vctk/vits"):
        """Initialize TTS with the specified multi-speaker model."""
        logger.debug(f"Initializing TTS with model: {model_name}")
        try:
            self.device = "cuda" if torch.cuda.is_available() else "cpu"
            self.tts = TTS(model_name=model_name, progress_bar=True)
            logger.info("TTS model loaded successfully!")
        except Exception as e:
            logger.error(f"Failed to load TTS model: {e}")
            raise

    def list_available_speakers(self):
        """List all available speakers in the model for selection."""
        try:
            available_speakers = self.tts.speakers
            logger.info(f"Available speakers: {available_speakers}")
            return available_speakers
        except AttributeError:
            logger.error("This model does not support multi-speaker functionality.")
            return None

    def generate_speech(self, text, speaker_id="p333", file_name="gusto_voice_output.wav", speed=1.0, pitch=1.0):
        """Generate speech and save it to a specified file."""
        if not text or not isinstance(text, str):
            logger.error("Invalid input text")
            return None

        output_path = os.path.join("audio_output", file_name)
        os.makedirs("audio_output", exist_ok=True)
        
        # Ensure speed and pitch are within a typical range
        speed = max(0.8, min(1.2, speed))
        pitch = max(0.9, min(1.2, pitch))
        
        logger.debug(f"Generating speech for text: '{text}' with speaker={speaker_id}, speed={speed}, and pitch={pitch}")
        
        try:
            # Generate TTS with specified speaker, speed, and pitch
            self.tts.tts_to_file(text=text, speaker=speaker_id, file_path=output_path, speed=speed, pitch=pitch)
            logger.info(f"Speech successfully saved to {output_path}")
            return output_path
        except Exception as e:
            logger.error(f"Error generating speech: {str(e)}")
            return None

# Main function to test the GustoTTS class with sample text
if __name__ == "__main__":
    logger.debug("Starting main program")
    
    # Check command line arguments
    input_text = "Hello, welcome to Gusto!" if len(sys.argv) < 2 else " ".join(sys.argv[1:])
    
    try:
        # Initialize and run the Gusto TTS
        gusto_tts = GustoTTS()
        
        # Display available speakers for the user
        speakers = gusto_tts.list_available_speakers()
        
        # Ensure the specified speaker exists
        if speakers and "p243" not in speakers:
            logger.warning("Speaker 'p243' not available; please choose from the listed speakers.")
        
        # Generate speech with specific speaker, speed, and pitch settings
        generated_file_path = gusto_tts.generate_speech(input_text, speaker_id="p243", speed=1.0, pitch=1.0)
        
        if generated_file_path:
            logger.info(f"Generated speech available at: {generated_file_path}")
        else:
            logger.error("Failed to generate speech")
            sys.exit(1)
            
    except Exception as e:
        logger.critical(f"Unexpected error in main: {e}")
        sys.exit(1)
