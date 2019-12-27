require 'dotenv'
require 'telegram/bot'
require 'byebug'
require "time"
require 'httparty'
require 'telegram/bot'
require 'rufus/scheduler'

Dotenv.load

token = ENV['TELEGRAM_TOKEN']

PHRASES = ["es una mierda", "me quiero ir"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when /mi rey/i
      response = HTTParty.get('http://inspirobot.me/api?generate=true')
      bot.api.send_photo(chat_id: message.chat.id, photo: response.body)
    when /que diria joaco/i
      bot.api.send_message(chat_id: message.chat.id, text: PHRASES.sample)
    end
  end
end
