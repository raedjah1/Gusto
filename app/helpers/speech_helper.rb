# app/helpers/speech_helper.rb
module SpeechHelper
    # Method to call eSpeak for text-to-speech
    def speak(text, speed: 150, pitch: 60, volume: 100, voice: 'en')
        system("espeak '#{text}' -s #{speed} -p #{pitch} -a #{volume} -v #{voice}")
      end
      
  end
  