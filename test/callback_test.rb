require_relative 'test_helper'

class CallbackTest < Minitest::Test
  attr_reader :callback, :message_params

  def setup
    @callback = Smscru::Callback.new(secret: 'zxc')
    @message_params = {
      'phone' => '123',
      'mes'   => 'text',
      'to'    => '234',
      'sha1'  => 'b6f768ce7614d7858cc4a6116f8ffd0dc236a3cd'
    }
  end

  def test_valid_signature
    verified = false
    callback.on_message { verified = true }

    callback.run(message_params)

    assert verified
  end

  def test_invalid_signature
    message_params['sha1'] = 'xxx'

    verified = false
    callback.on_message { verified = true }

    callback.run(message_params)

    refute verified
  end
end
