require 'dotenv'
require 'telegram/bot'
require 'byebug'
require "time"
require 'httparty'
require 'telegram/bot'
require 'rufus/scheduler'

Dotenv.load

token = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      while true do
        scheduler = Rufus::Scheduler.new
        scheduler.cron '0 16 * * *' do
          response = HTTParty.get('http://inspirobot.me/api?generate=true')
          bot.api.send_photo(chat_id: message.chat.id, photo: response.body)
        end
      end
    end
  end
end
