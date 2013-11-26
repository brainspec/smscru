require_relative 'test_helper'

class ClientTest < Minitest::Test
  def test_dont_override_global_configuration
    Smscru.configure(login: 'qwe')
    client = Smscru::Client.new(login: 'asd')

    assert_equal 'qwe', Smscru.config.login
    assert_equal 'asd', client.config.login
  end
end
