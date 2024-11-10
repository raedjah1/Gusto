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
    def __init__(self, model_name="tts_models/en/ljspeech/tacotron2-DDC"):
        # Initialize TTS with the specified model
        logger.debug(f"Initializing TTS with model: {model_name}")
        try:
            device = "cuda" if torch.cuda.is_available() else "cpu"
            self.tts = TTS(model_name=model_name, progress_bar=True).to(device)
            logger.info("TTS model loaded successfully!")
        except Exception as e:
            logger.error(f"Failed to load TTS model: {e}")
            raise

    def generate_speech(self, text, file_name="gusto_voice_output.wav"):
        # Input validation
        if not text or not isinstance(text, str):
            logger.error("Invalid input text")
            return None
            
        logger.debug(f"Generating speech for text: '{text}'")
        logger.debug(f"Output filename: {file_name}")
        
        # Generate speech from text and save to file
        try:
            output_path = os.path.join("audio_output", file_name)
            os.makedirs("audio_output", exist_ok=True)  # Create output directory
            
            self.tts.tts_to_file(text=text, file_path=output_path)
            
            # Verify file was created
            if os.path.exists(output_path):
                logger.info(f"Speech successfully saved to {output_path}")
                return output_path
            else:
                logger.error("File was not created despite no exceptions")
                return None
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
        generated_file_path = gusto_tts.generate_speech(input_text)
        
        if generated_file_path:
            logger.info(f"Generated speech available at: {generated_file_path}")
        else:
            logger.error("Failed to generate speech")
            sys.exit(1)
            
    except Exception as e:
        logger.critical(f"Unexpected error in main: {e}")
        sys.exit(1)
