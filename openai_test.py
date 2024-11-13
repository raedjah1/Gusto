import os
from openai import OpenAI

# Make sure your OpenAI API key is set as an environment variable
api_key = os.getenv("OPENAI_API_KEY")
if not api_key:
    raise ValueError("OPENAI_API_KEY environment variable is missing.")

# Initialize the OpenAI client
client = OpenAI(api_key=api_key)

def test_openai_api():
    conversation_history = [
        {
            "role": "system",
            "content": "You are a helpful assistant for dining recommendations."
        },
        {
            "role": "user",
            "content": "Can you suggest a nice meal for dinner?"
        }
    ]

    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo-instruct",  # Make sure you have access to this model
            messages=conversation_history
        )
        assistant_reply = response.choices[0].message['content']
        print("Assistant:", assistant_reply)
    except Exception as e:
        print(f"Error with OpenAI API: {e}")

if __name__ == "__main__":
    test_openai_api()
