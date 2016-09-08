require 'json'
require 'bunny'
class Chat

  def display_message(user, message)
    puts "#{user}: #{message}"
  end

  def initialize
    print "Type in your name: "
    @current_user = gets.strip
    puts "Hi #{@current_user}, you just joined a chat room! Type your message in and press enter."

    conn = Bunny.new
    conn.start

    @channel = conn.create_channel
    @exchange = @channel.fanout("super.chat")

    listen_for_messages
  end

  def listen_for_messages
    queue = @channel.queue("")

    queue.bind(@exchange).subscribe do |delivery_info, metadata, payload|
      data = JSON.parse(payload)
      display_message(data['user'], data['message'])
    end
  end

  def publish_message(user, message)
  end

  def wait_for_message
    message = gets.strip
    publish_message(@current_user, message)
    wait_for_message
  end

end

chat = Chat.new
chat.wait_for_message
