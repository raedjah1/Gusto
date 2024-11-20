 ## Gusto
======

 Group Members : Jah, Victor and Chris


Concept: A platform that connects private chefs with consumers seeking personalized dining experiences. The app allows chefs to showcase their menus, specialties, and services, while consumers can browse, book, and review chefs.

Target Users

* Private Chefs: Professionals looking to offer their culinary services to a wider audience.
* Consumers: Individuals or groups seeking personalized dining experiences, such as private dinners, events, or cooking classes.

# Key Features
-------------

For Chefs
---------

* Profile Creation:
    * Personal bio
    * Culinary specialties
    * Menu offerings
    * Pricing details
    * Availability calendar
* Portfolio Showcase:
    * Photo gallery of dishes
    * Customer reviews and ratings
* Booking Management:
    * Accept or decline booking requests
    * Manage schedule and availability
* Messaging System:
    * Communicate with potential clients
* Notifications:
    * Alerts for new bookings, messages, and reviews

For Consumers
--------------


* Chef Browsing:
    * Search and filter chefs based on cuisine, location, price, and availability
* Profile Viewing:
    * View chef profiles, menus, and reviews
* Booking Requests:
    * Request a booking for a specific date and time
    * Specify event details and special requests
* Payment Processing:
    * Secure payment options (this may be simulated for the project)
* Reviews and Ratings:
    * Leave feedback on the dining experience
* Favorites List:
    * Save favorite chefs for future bookings
* Messaging System:
    * Communicate directly with chefs

Additional Features (Optional/Advanced)

* Location Services:
    * Map integration to show chefs available in a specific area
* Push Notifications:
    * Real-time updates on booking status and messages
* Social Media Integration:
    * Share experiences or favorite chefs on social platforms
* Admin Dashboard:
    * Manage users, monitor activity, handle disputes

User Stories(flow)
-------------------

1. Chef Profile Creation
    * As a private chef, I want to create a profile so that I can showcase my culinary skills to potential clients.
2. Consumer Browsing
    * As a consumer, I want to browse chefs based on cuisine and price so that I can find the perfect chef for my event.
3. Booking Request
    * As a consumer, I want to request a booking with a chef so that I can arrange a private dining experience.
4. Manage Bookings
    * As a chef, I want to manage my bookings so that I can accept or decline requests and organize my schedule.
5. Reviews and Ratings
    * As a consumer, I want to leave a review after my dining experience so that I can provide feedback and help others make informed decisions.
6. Messaging System
    * As a consumer, I want to message a chef before booking so that I can discuss menu options and special requests.
7. Notifications
    * As a chef, I want to receive notifications of new booking requests so that I can respond promptly.
8. Favorites List
    * As a consumer, I want to save chefs to a favorites list so that I can easily find them later.


# # App layout for Testing(spec), Models, Views and Controller:


Models
-------

* User (roles: chef, consumer)
* ChefProfile (to store chef-specific data)
* Booking (to manage bookings between consumers and chefs)
* Review (to store consumer reviews of chefs)
* MenuItem (to allow chefs to display their menus)
* Message (for communication between chefs and consumers)

Model Relationships:
--------------------
* A User can be a Chef or a Consumer.
* A ChefProfile belongs to a User.
* A Booking belongs to a User (consumer) and a ChefProfile.
* A Review belongs to both User (consumer) and ChefProfile.
* A MenuItem belongs to a ChefProfile.
* A Message belongs to both User and can be exchanged between users (chefs and consumers).

Schema Overview:
-----------------

Table	Fields
Users	id, name, email, password_digest, role
ChefProfiles	user_id, bio, specialty, experience, availability
Bookings	user_id, chef_profile_id, date, status
Reviews	user_id, chef_profile_id, rating, comments
MenuItems	chef_profile_id, name, description, price
Messages	sender_id, receiver_id, content
potenitals(TTS, whisper,etc)

Spec(files for testing)
-----------------------

spec/
├── controllers/
│   ├── chef_profiles_controller_spec.rb
│   ├── bookings_controller_spec.rb
│   ├── reviews_controller_spec.rb
│   ├── messages_controller_spec.rb
│   └── users_controller_spec.rb
├── factories/
│   ├── bookings.rb
│   ├── chef_profiles.rb
│   ├── menu_items.rb
│   ├── reviews.rb
│   ├── users.rb
├── models/
│   ├── booking_spec.rb
│   ├── chef_profile_spec.rb
│   ├── menu_item_spec.rb
│   ├── review_spec.rb
│   ├── message_spec.rb
│   └── user_spec.rb
├── requests/
│   ├── chef_profiles_spec.rb
│   ├── bookings_spec.rb
│   ├── reviews_spec.rb
│   ├── messages_spec.rb
│   └── users_spec.rb
├── support/
│   └── devise.rb  # Devise test helpers
├── spec_helper.rb
└── rails_helper.rb


HTML files (views)
-------------------

app/
├── views/
│   ├── users/
│   │   ├── new.html.erb
│   │   ├── edit.html.erb
│   │   └── sessions/new.html.erb
│   ├── chef_profiles/
│   │   ├── index.html.erb
│   │   ├── show.html.erb
│   │   ├── edit.html.erb
│   │   └── _profile_header.html.erb
│   ├── bookings/
│   │   ├── new.html.erb
│   │   ├── index.html.erb
│   │   ├── show.html.erb
│   │   └── _booking_form.html.erb
│   ├── reviews/
│   │   ├── index.html.erb
│   │   ├── new.html.erb
│   │   ├── show.html.erb
│   │   └── _review_form.html.erb
│   ├── menu_items/
│   │   ├── new.html.erb
│   │   ├── edit.html.erb
│   │   └── index.html.erb
│   ├── messages/
│   │   ├── index.html.erb
│   │   ├── show.html.erb
│   │   └── new.html.erb
│   └── shared/
│       ├── _header.html.erb
│       ├── _footer.html.erb
│       └── _form_errors.html.erb


Views
------

Chef Profile Page Structure:
1. Profile Header (app/views/chefs/_profile_header.html.erb)
    * Shows chef's profile picture, name, and specialties.
2. Menu Section (app/views/chefs/_menu_section.html.erb)
    * Displays a list of the chef's menu items.
3. Reviews Section (app/views/chefs/_reviews_section.html.erb)
    * Displays customer reviews and ratings.
4. Booking Button (app/views/shared/_booking_button.html.erb)
    * Provides a button for booking a chef.

5. //add


Controllers 
------------

1. UsersController: Handles user registration and profile management.
2. ChefProfilesController: Manages chef profiles, including creating and updating profiles.
3. BookingsController: Manages consumer bookings with chefs.
4. ReviewsController: Allows consumers to leave reviews and ratings for chefs.
5. MessagesController: Manages messaging between users.
=======




Jah's notes(possible features):
-----------

📢 Voice-Interactive Gusto Feature
The Voice-Interactive Gusto feature offers users a dynamic and conversational way to discover meals, cuisines, and chefs based on their preferences. Powered by Whisper for speech-to-text and Mozilla TTS for text-to-speech, this feature provides a seamless voice-enabled experience with visual suggestions.

🎯 Key Functionality
Voice Input Recognition:

Uses Whisper’s speech-to-text capability to recognize user commands.
Interprets phrases such as “I’m hungry,” “I want Italian,” or “Show me options” to guide the interaction.
Conditional Question Flow:

Gusto asks a series of branching questions, gathering details about the user's preferences in a conversational style.
Questions adjust dynamically based on prior responses (e.g., "Do you prefer Italian or Chinese cuisine?").
Visual Suggestions:

Displays clickable options for each question to guide indecisive users and provide inspiration.
Options are dynamically generated based on the user’s previous choices, like “Quick Meals,” “Popular Near You,” or specific cuisine types.
Chef and Dish Recommendations:

Based on user preferences, Gusto presents mock recommendations of chefs or dishes tailored to the user's selected criteria.
Users can either respond by voice or select recommendations directly from the display.
Optional Interaction Buttons:

For each question, quick-reply buttons such as “Italian,” “Surprise Me!” or “Top Rated” allow the user to continue by tapping instead of speaking.
Simulated Booking Experience:

After finalizing preferences, users are presented with booking options to simulate reserving a meal or chef experience.
💻 Technical Overview
Speech-to-Text: Whisper transcribes user input and interprets phrases to guide the interaction.
Text-to-Speech: Mozilla TTS generates realistic, natural-sounding audio responses from Gusto.
Conditional Logic: The feature uses conditional branches to control the question flow based on user input.
Visual Interface: For each prompt, options are displayed as interactive tiles or buttons, enabling users to interact by either speaking or tapping.
📜 Example User Flow
Gusto Initiates: “Hi! What type of meal are you interested in today?”
User Response (by voice or tap): “Italian.”
Gusto Asks Follow-up: “Got it! Do you prefer something quick or a full course?”
User Choice: Taps on “Quick.”
Recommendation Displayed: Gusto presents a list of Italian quick meals, like “Margherita Pizza” or “Pasta Carbonara,” and offers a “Tell Me More” button.

Victor's notes(in-process features):
-----------

1. Modify the GustoGram page to make each chef's picture clickable, redirecting to a dedicated Chef Menu Page (like instagram homepage).
 
2. On the Chef Menu Page, list the menu items (e.g., "Jerk Chicken," "Barbecue Beef")
in a visually amusing way (like a decent menu).
  
3. Make each menu item clickable, redirecting to a page showing the image of the food.

4. Add a return icon on Gustogram. Currently the user have to manually cllick on the "returning" on webpage in order to go back. 
Attempt to add features such that the user is able to go back to the homepage at any page it currently is. 


