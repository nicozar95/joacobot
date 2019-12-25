require 'dotenv'
require 'telegram/bot'
require 'byebug'
require "time"
require 'httparty'
require 'telegram/bot'

Dotenv.load

token = ENV['TELEGRAM_TOKEN']

byebug
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      while true do
        response = HTTParty.get('http://inspirobot.me/api?generate=true')
        bot.api.send_photo(chat_id: message.chat.id, photo: response.body)
        sleep(ENV['SLEEP_TIME'].to_i)
      end
    end
  end
end