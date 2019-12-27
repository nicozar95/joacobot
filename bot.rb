require 'dotenv'
require 'telegram/bot'
require 'byebug'
require "time"
require 'httparty'
require 'telegram/bot'
require 'rufus/scheduler'

Dotenv.load

token = ENV['TELEGRAM_TOKEN']

PHRASES = ["es una mierda", "me quiero ir", "malardo", "buenardo",
           "q haces mi rey?", "ya fue, hago home", "arre", "same", "q paja",
           "ya fue, renuncio", "LOCO NO ME DAN PERMISOS!", "me voy a fumar un pucho",
           "QUE PAJA ESTE PROYECTOOOOOOoooooOoooO!", "josena que opinas?", "me voy a pasar a rails",
           "Que cringe", "de rucula"]

PEOPLE = ["paquito amoroso", "leon", "truenito", "nicki nicole","bokita el mas grande papa"]

TIME = ["dias", "horas"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when /quien/i
      bot.api.send_message(chat_id: message.chat.id, text: PEOPLE.sample)
    when /el otro dia|la otra vez|me paso/i
      bot.api.send_message(chat_id: message.chat.id, text: "como en one piece")
    when /cuanto|cuando/
      text = "#{rand(1..100)} #{TIME.sample}"
      bot.api.send_message(chat_id: message.chat.id, text: text)
    when /mi rey/i
      response = HTTParty.get('http://inspirobot.me/api?generate=true')
      bot.api.send_photo(chat_id: message.chat.id, photo: response.body)
    when /joacobot|rey joaco/i
      bot.api.send_message(chat_id: message.chat.id, text: PHRASES.sample)
    end
  end
end
