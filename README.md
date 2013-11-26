# Smscru

A Ruby interface to the [smsc.ru](http://smsc.ru/) SMS gateway service.

## Installation

Add this line to your application's Gemfile:

    gem 'smscru'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smscru

## Usage

Global configuration:

```ruby
Smscru.configure do |config|
  config.login    = 'smscuser'    # Your login
  config.password = 'passwordmd5' # MD5 of your password
  config.secret   = 'smscsecret'  # Secret for receiving messages
end
```

Or:

```ruby
Smscru.configure(login: 'smscuser', password: 'passwordmd5', secret: 'smscsecret')
```

### Sending messages

```ruby
client = Smscru::Client.new
client.send_message('Hello world!', '+1234567890')
client.send_message('Hello world!', '+1234567890', id: 456)
client.send_message('Hello world!', '+1234567890', sender: 'TestSender')
client.send_message('Hello world!', ['+1234567890', '+1234567891'])
```

It's also possible to specify client configuration options:

```ruby
Smscru::Client.new(login: 'smscuser', password: 'passwordmd5')
```

### Receiving messages and status updates

URL in settings:

```
http://example.com/smscru?charset=utf-8&sha1=smscsecret
```

Use your custom secret instead of `smscsecret`.

Routes:

```ruby
post 'smscru' => 'smscru#callback'
```

Controller:

```ruby
require 'smscru'

class SmscruController < ActionController::Base
  def callback
    callback = Smscru::Callback.new

    callback.on_message do |params|
      p params # incoming message
    end

    callback.on_status do |params|
      p params # outgoing message status update
    end

    callback.run(params)

    render nothing: true
  end
end
```

You can use [proxylocal](http://proxylocal.com/) or [ngrok](https://ngrok.com/) to test your callback handler on local machine.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
