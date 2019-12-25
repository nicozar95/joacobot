require 'dotenv'
require 'telegram/bot'
require 'byebug'
require "time"

Dotenv.load

token = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      while true do
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        sleep(ENV['SLEEP_TIME'])
      end
  end
end