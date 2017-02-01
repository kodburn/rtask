require 'json'
require 'bunny'

class RubyChat

  def display_message(user, message)
    puts "#{user}: #{message}"
  end

  def initialize
    print 'Type in your name: '
    @current_user = gets.strip
    puts "Hi #{@current_user}, you just joined a chat room!
          Type your message in and press enter."

    conn = Bunny.new
    conn.start

    @channel = conn.create_channel
    @exchange = @channel.fanout('super.chat')

    listen_for_messages
  end

  def listen_for_messages
    queue = @channel.queue('')
    queue.bind(@exchange).subscribe do |_delivery_info, _metadata, payload|
      data = JSON.parse(payload)
      display_message(data['user'], data['message'])
    end
  end

  def publish_message(user, message)
    data = JSON.generate(user: user, message: message)
    @exchange.publish(data)
  end

  def wait_for_message
    message = gets.strip
    publish_message(@current_user, message)
    wait_for_message
  end
end

chat = RubyChat.new
chat.wait_for_message
