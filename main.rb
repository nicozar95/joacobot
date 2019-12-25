#!/usr/bin/env ruby

require 'telegram/bot'

# Set enviroment vars TOKEN and BOT_USERNAME
TOKEN = ENV['TOKEN']
BOT_USERNAME = ENV['BOT_USERNAME']

def get(word, username='')
  return word+username
  Regexp.new("/#{word}|#{word}#{BOT_USERNAME}")
end

def show_params
  puts "[INFO] Params:"
  puts "* TOKEN        = #{TOKEN}"
  puts "* BOT_USERNAME = #{BOT_USERNAME}"
  puts "[INFO] Running bot #{$0}..."
end

show_params
Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    puts " => #{message.text}"
    case message.text
    when get('/hello')
      bot.api.send_message(chat_id: message.chat.id, text: "Hello Word!")
    when get('/hello', BOT_USERNAME)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello Word!")
    when Regexp.new("/bye|bye#{BOT_USERNAME}")
      bot.api.send_message(chat_id: message.chat.id, text: "Bye bye!")
      exit
    end
  end
end