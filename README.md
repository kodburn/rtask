# Elixir/Ruby RabbitMQ Chat
Chat has two clients written in Ruby, Elixir and uses RabbitMQ as a server

## Set up
### Prerequisites
Install the following packages:
* [Elixir](http://elixir-lang.org/install.html)
* [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [RabbitMQ](https://www.rabbitmq.com/download.html)

### Configure the environment
Set the RUBY_THREAD_VM_STACK_SIZE variable to 104857600 to avoid SystemStackError in the Ruby client
```
export RUBY_THREAD_VM_STACK_SIZE=104857600
```
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
