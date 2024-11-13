import datetime
import random
from textblob import TextBlob  # For basic sentiment analysis

# Simulated user history for demonstration
user_history = {
    'favorite_cuisines': ['Italian', 'Mexican'],
    'recent_orders': ['Pasta Carbonara', 'Tacos'],
}

def get_initial_prompt():
    """Returns the initial question to start the conversation, based on meal time."""
    meal_time = determine_meal_time()
    return f"Hi! Good {meal_time}. What kind of meal are you interested in today?"

def determine_meal_time():
    """Determine the appropriate meal time based on the current time of day."""
    now = datetime.datetime.now().time()
    if now < datetime.time(10, 30):
        return 'morning (breakfast)'
    elif now < datetime.time(14, 00):
        return 'afternoon (lunch)'
    elif now < datetime.time(18, 00):
        return 'afternoon (brunch)'
    else:
        return 'evening (dinner)'

def get_next_prompt(user_input):
    """Generates the next conversational prompt based on user input and context."""
    user_input = user_input.lower()

    # Sentiment analysis to adjust tone of response
    sentiment = TextBlob(user_input).sentiment.polarity
    if sentiment > 0.5:
        mood_response = "It sounds like you're in a great mood!"
    elif sentiment < -0.5:
        mood_response = "Let's see if we can cheer you up with some tasty options."
    else:
        mood_response = "I’m here to help you find something delicious!"

    # Check if user asks for a recommendation
    if "suggest" in user_input or "recommend" in user_input:
        return f"{mood_response} {suggest_dish_or_cuisine()}"

    # Check if user mentions specific cuisines or meal types
    cuisines = ['italian', 'mexican', 'chinese', 'japanese', 'indian']
    for cuisine in cuisines:
        if cuisine in user_input:
            return f"{mood_response} Perfect! How about trying a new {cuisine} dish? Would you prefer something quick or a full course?"

    # Handle phrases indicating hunger or urgency
    if "hungry" in user_input or "starving" in user_input:
        return f"{mood_response} Sounds like you’re really hungry! Would you like something quick and filling?"

    # Fallback response for unknown input
    return f"{mood_response} Could you specify a type of cuisine, or just say 'Surprise me!' if you’re feeling adventurous?"

def suggest_dish_or_cuisine():
    """Suggest a dish or cuisine based on user history or popular trends."""
    # Use user's favorite cuisines if available
    if user_history.get('favorite_cuisines'):
        cuisine = random.choice(user_history['favorite_cuisines'])
        return f"Based on your favorites, how about some {cuisine} today?"

    # Provide a popular dish recommendation as a fallback
    popular_dishes = ['Sushi', 'Burrito', 'Margherita Pizza', 'Pad Thai', 'Burger']
    return f"How about trying {random.choice(popular_dishes)}? It’s quite popular right now!"

def get_location_based_suggestion():
    """Optional: Suggest dishes or cuisines popular in the user's location."""
    # This function could use a location-based API or mock data
    nearby_trends = ['BBQ Ribs', 'Pho', 'Dim Sum', 'Paella', 'Tacos']
    return f"Here’s a popular choice near you: {random.choice(nearby_trends)}. Would you like to give it a try?"
