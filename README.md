# Elixir/Ruby RabbitMQ Chat
This simple chat has two clients written in Ruby and Elixir; uses RabbitMQ as a server.

![ScreenShot](https://cloud.githubusercontent.com/assets/10180759/22531711/f73cf3ec-e8e2-11e6-99c9-30cfa37bb4d4.png)

## Set up
### Prerequisites
Install the following packages:
* [Elixir](http://elixir-lang.org/install.html)
* [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [RabbitMQ](https://www.rabbitmq.com/download.html)

## Run
### Start RabbitMQ server
```
rabbitmq-server
```
### Launch Elixir client
Go to elixir_chat directory
```
cd elixir_chat
```
Install dependencies
```
mix deps.get
```
Run the client
```
mix run
```
### Launch Ruby client
Go to ruby_chat directory
```
cd ruby_chat
```
Install gems
```
bundle install
```
Run the client
```
ruby ruby_chat.rb
```
## Close
Type Ctrl+D in both app to exit the chat
