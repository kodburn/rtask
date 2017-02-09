require 'json'
require 'bunny'

# RabbitMQ Ruby Client
class RubyChat
  # Greets and asks user the name
  # Sets up the connection to RabbitMQ server
  def initialize
    print 'Type in your name: '
    @current_user = gets.strip
    puts "Hi #{@current_user}, you just joined a chat room!"\
         'Type your message in and press enter.'

    conn = Bunny.new
    conn.start

    @channel = conn.create_channel
    @exchange = @channel.fanout('super.chat')

    listen_for_messages

    # Use loop to avoid recursion
    loop { wait_for_message }
  end

  # Displays the decoded message
  def display_message(user, message)
    puts "#{user}: #{message}"
  end

  # Listens to the exchange using the bounded queue
  # Decodes the message and displays it
  def listen_for_messages
    queue = @channel.queue('')
    queue.bind(@exchange).subscribe do |_delivery_info, _metadata, payload|
      data = JSON.parse(payload)
      display_message(data['user'], data['message'])
    end
  end

  # Encodes message to JSON and publishes it to the exchange
  def publish_message(user, message)
    data = JSON.generate(user: user, message: message)
    @exchange.publish(data)
  end

  # Waits for user to input the message and publishes it
  def wait_for_message
    message = gets.strip
    publish_message(@current_user, message)
  end
end

# Creates new chat and wait for user to input
RubyChat.new
