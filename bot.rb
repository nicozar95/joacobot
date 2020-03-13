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
           "QUE PAJA ESTE PROYECTOOOOOOoooooOoooO!", "me voy a pasar a rails",
           "Que cringe", "de rucula", "como en one piece", "la unica droga q consumo es el amor",
           "¿cuanto tiempo de licencia me dan si me rompo una pierna?", "no se si quiero seguir siendo desarrollador",
           "me quiero ir a mi casa", "los voy a denunciar", "chau me voy", "el pan es un veneno"]

PEOPLE = ["paquito amoroso", "leon", "truenito", "nicki nicole","bokita el mas grande papa", "el payaso plin plin"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when /quien joaco/i
      bot.api.send_message(chat_id: message.chat.id, text: PEOPLE.sample)
    when /mi rey/i
      response = HTTParty.get('http://inspirobot.me/api?generate=true')
      bot.api.send_photo(chat_id: message.chat.id, photo: response.body)
    when /joacobot|rey joaco|rey/i
      bot.api.send_message(chat_id: message.chat.id, text: PHRASES.sample)
    end
  end
end
