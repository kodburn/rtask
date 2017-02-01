defmodule ElixirChat do

  def start do
    user = IO.gets("Type in your name: ") |> String.strip
    IO.puts "Hi #{user}, you just joined a chat room! Type your message in and press enter."

    {:ok, conn} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(conn)
    {:ok, queue_data } = AMQP.Queue.declare channel, ""

    AMQP.Exchange.fanout(channel, "super.chat")
    AMQP.Queue.bind channel, queue_data.queue, "super.chat"
    
    listen_for_messages(channel, queue_data.queue)
    wait_for_message(user, channel)
  end

  def wait_for_message(user, channel) do
    message = IO.gets("") |> String.strip
    publish_message(user, message, channel)
    wait_for_message(user, channel)
  end

  def listen_for_messages(channel, queue_name) do
    AMQP.Queue.subscribe channel, queue_name, fn(payload, metadata) ->
      { :ok, data } = JSON.decode(payload)
      display_message(data["user"], data["message"])
    end
  end

  def display_message(user, message) do
    IO.puts "#{user}: #{message}"
  end

  def publish_message(user, message, channel) do
    { :ok, data } = JSON.encode([user: user, message: message])
    AMQP.Basic.publish channel, "super.chat", "", data
  end

end

ElixirChat.start
