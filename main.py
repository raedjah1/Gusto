import os
import openai
from generate_speech import GustoTTS
import whisper
import sounddevice as sd
import soundfile as sf
import time

# Ensure OpenAI API key is loaded from the environment
openai.api_key = os.getenv("OPENAI_API_KEY")

def capture_user_input():
    """Capture and transcribe user input with Whisper."""
    print("Listening for user input...")
    fs = 16000  # Sample rate
    duration = 5  # Duration in seconds
    recording = sd.rec(int(duration * fs), samplerate=fs, channels=1, dtype='int16')
    sd.wait()  # Wait until recording is finished
    
    audio_path = 'user_input.wav'
    sf.write(audio_path, recording, fs)  # Save recording to file

    # Load the Whisper model only once
    if not hasattr(capture_user_input, "model"):
        capture_user_input.model = whisper.load_model("base")
    model = capture_user_input.model

    result = model.transcribe(audio_path)
    return result.get("text", "")

def play_audio(file_path):
    """Play the generated audio response."""
    try:
        data, fs = sf.read(file_path, dtype='float32')
        sd.play(data, fs)
        sd.wait()
    except Exception as e:
        print(f"Error playing audio: {e}")

def get_llm_response(user_input, conversation_history):
    """Get response from OpenAI's GPT-4 model."""
    conversation_history.append({"role": "user", "content": user_input})

    # Create a chat completion using the OpenAI API
    client = openai.OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
    
    response = client.chat.completions.create(
        model="gpt-3.5-turbo-instruct",
        messages=conversation_history
    )

    assistant_reply = response['choices'][0]['message']['content'].strip()
    conversation_history.append({"role": "assistant", "content": assistant_reply})

    return assistant_reply

def main():
    gusto_tts = GustoTTS()
    conversation_history = []

    # Initial system prompt to set the assistant's role and behavior
    system_prompt = {
        "role": "system",
        "content": (
            "You are Gusto, a sophisticated virtual dining assistant. "
            "Help users discover meals, cuisines, and chefs based on their preferences, mood, and time of day. "
            "Ask thoughtful questions to gather preferences and provide tailored dining recommendations. "
            "Your responses should feel friendly, engaging, and be helpful in guiding the user’s dining journey."
        )
    }
    conversation_history.append(system_prompt)

    # Initial greeting
    initial_prompt = "Hi! How can I assist you with your dining choices today?"
    print("Gusto:", initial_prompt)
    gusto_tts.generate_speech(initial_prompt, file_name="gusto_initial.wav")
    play_audio("audio_output/gusto_initial.wav")

    while True:
        user_input = capture_user_input()
        print("User:", user_input)

        if not user_input:
            prompt = "I'm sorry, I didn't catch that. Could you please repeat?"
            print("Gusto:", prompt)
            gusto_tts.generate_speech(prompt, file_name="gusto_repeat.wav")
            play_audio("audio_output/gusto_repeat.wav")
            continue

        if user_input.lower() in ["exit", "quit"]:
            farewell = "Thanks for chatting with Gusto! Enjoy your meal!"
            print("Gusto:", farewell)
            gusto_tts.generate_speech(farewell, file_name="gusto_farewell.wav")
            play_audio("audio_output/gusto_farewell.wav")
            break

        # Get response from OpenAI's GPT-4
        try:
            assistant_reply = get_llm_response(user_input, conversation_history)
        except Exception as e:
            print(f"Error with OpenAI API: {e}")
            assistant_reply = "I'm sorry, I'm having trouble processing your request right now."

        print("Gusto:", assistant_reply)
        gusto_tts.generate_speech(assistant_reply, file_name="gusto_response.wav")
        play_audio("audio_output/gusto_response.wav")
        time.sleep(0.5)  # Short pause to avoid abrupt transitions

if __name__ == "__main__":
    main()
